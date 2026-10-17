import QtQuick
import QtQuick.Layouts
import QtMultimedia
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

Panel {
  id: root
  moduleName: "merlijn.droidcam"
  ipcTarget: "merlijn.droidcam"

  property string cliPath: Quickshell.env("HOME") + "/.local/bin/droidcamctl"
  property string runtimeDir: Quickshell.env("XDG_RUNTIME_DIR") + "/droidcam-watch"
  property string statusPath: runtimeDir + "/status.json"
  property var webcamStatus: ({
    state: "starting",
    reason: "status_pending",
    ready: false,
    service_enabled: true,
    service_active: false
  })
  property bool actionBusy: false
  property string actionError: ""
  property var desiredEnabled: null
  property int cursorIndex: 0
  property bool previewDeviceAvailable: false
  property bool previewHasFrames: false
  property double previewLastFrameMs: 0

  readonly property int refreshIntervalSec: Math.max(15, Number(setting("refreshIntervalSec", 60)))
  readonly property string state: String(webcamStatus.state || "error")
  readonly property bool serviceEnabled: webcamStatus.service_enabled === true
  readonly property bool displayEnabled: desiredEnabled === null ? serviceEnabled : desiredEnabled === true
  readonly property bool serviceActive: webcamStatus.service_active === true
  readonly property bool streaming: state === "streaming" && webcamStatus.ready === true
  readonly property color foreground: bar ? bar.foreground : Color.foreground
  readonly property color urgent: bar ? bar.urgent : Color.urgent
  readonly property color dim: Qt.darker(foreground, 1.55)
  readonly property string fontFamily: bar ? bar.fontFamily : Style.font.family
  // Red is reserved for the active privacy indicator, never disconnection.
  readonly property color iconColor: streaming ? urgent : (displayEnabled && state !== "waiting_device" ? foreground : dim)
  readonly property string statusText: {
    if (!displayEnabled) return "Auto-connect disabled"
    if (state === "streaming") return "Streaming to DroidCam"
    if (state === "waiting_device") return "Waiting for iPhone"
    if (state === "waiting_app") return "Open DroidCam on iPhone"
    if (state === "connecting") return "Connecting to iPhone"
    if (state === "backoff") return "Reconnecting"
    if (state === "blocked") return "Another DroidCam client is running"
    if (state === "conflict") return "Multiple iOS devices detected"
    if (state === "starting") return "Starting auto-connect"
    if (state === "stopped") return "Auto-connect stopped"
    return "DroidCam needs attention"
  }
  readonly property string reasonText: {
    var reason = String(webcamStatus.reason || "")
    if (reason === "") return "Camera frames are flowing"
    if (reason === "iphone_absent") return "Connect the paired iPhone over USB-C"
    if (reason === "iphone_initializing") return "Waiting for iPhone pairing services"
    if (reason === "usbmuxd_starting") return "Waiting for usbmuxd to start"
    if (reason === "waiting_for_frames") return "Waiting for the iPhone app to send video"
    if (reason === "connect_timeout" || reason.indexOf("client_exited_") === 0) return "Keep the iPhone unlocked with DroidCam open"
    if (reason === "frame_stalled") return "Video stopped; retrying automatically"
    if (reason === "video_device_released") return "DroidCam released the virtual webcam; retrying"
    if (reason === "multiple_ios_devices") return "DroidCam 2.1.5 can only select the first iOS device"
    if (reason === "external_client") return "Close the manually launched DroidCam client"
    if (reason === "video_device_missing") return "/dev/droidcam-video is missing; run droidcamctl doctor"
    if (reason === "video_device_wrong") return "The configured video node is not the DroidCam loopback"
    if (reason === "usbmuxd_unavailable") return "usbmuxd is unavailable"
    if (reason === "status_stale") return "The watcher stopped updating its status"
    if (reason === "auto_connect_disabled") return "Use the switch to enable it persistently"
    if (reason === "service_inactive") return "The enabled watcher is not running"
    if (reason === "clear_keep_format_failed") return "Could not reset the V4L2 loopback format"
    return reason.replace(/_/g, " ")
  }
  readonly property string resolutionText: String(webcamStatus.size || "1920x1080").replace("x", "×")
  readonly property bool previewRequested: opened && streaming
  readonly property string tooltipText: "iPhone Webcam: " + statusText
  readonly property string clientErrorText: {
    var lines = String(webcamStatus.last_client_error || "").split("\n")
    return lines.length > 0 ? String(lines[lines.length - 1]) : ""
  }

  function clearPreview() {
    previewDeviceAvailable = false
    previewHasFrames = false
    previewLastFrameMs = 0
  }

  function isPreviewDevice(device) {
    var description = String(device.description || "").toLowerCase()
    var deviceId = String(device.id || "")
    var target = String(webcamStatus.video_target || "/dev/video10")
    var node = target.substring(target.lastIndexOf("/") + 1)
    return description.indexOf("droidcam") !== -1
      || deviceId === target
      || deviceId === node
      || deviceId.indexOf("/" + node) !== -1
  }

  function refreshPreviewDevice() {
    clearPreview()
    if (!previewRequested || !previewBackendLoader.item) return
    previewBackendLoader.item.refreshDevice()
  }

  function applyStatus(raw) {
    try {
      var parsed = typeof raw === "string" ? JSON.parse(String(raw).trim()) : raw
      if (!parsed || typeof parsed !== "object") return
      var reportsEnabled = parsed.service_enabled !== undefined
      if (!reportsEnabled) parsed.service_enabled = root.webcamStatus.service_enabled
      if (parsed.service_active === undefined) parsed.service_active = true
      root.webcamStatus = parsed
      if (reportsEnabled) root.desiredEnabled = null
    } catch (error) {
      root.webcamStatus = {
        state: "error",
        reason: "invalid_status",
        ready: false,
        service_enabled: root.serviceEnabled,
        service_active: false
      }
    }
  }

  function refresh() {
    if (!statusProcess.running) statusProcess.running = true
  }

  function runAction(action) {
    if (actionBusy || actionProcess.running) return
    actionBusy = true
    actionError = ""
    if (action === "toggle") desiredEnabled = !serviceEnabled
    actionProcess.command = [cliPath, action]
    actionProcess.running = true
  }

  function moveCursor(_dx, dy) {
    if (dy > 0) cursorIndex = 1
    else if (dy < 0) cursorIndex = 0
  }

  function activateCursor() {
    if (cursorIndex === 0) runAction("toggle")
    else if (serviceEnabled) runAction("reconnect")
  }

  function checkLease() {
    if (!serviceActive || !webcamStatus.lease_until) return
    var expiry = Date.parse(String(webcamStatus.lease_until))
    if (!isNaN(expiry) && Date.now() > expiry) {
      var stale = {}
      for (var key in webcamStatus) stale[key] = webcamStatus[key]
      stale.state = "error"
      stale.reason = "status_stale"
      stale.ready = false
      webcamStatus = stale
    }
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  onOpenedChanged: {
    if (opened) {
      cursorIndex = 0
      refresh()
      Qt.callLater(function() {
        keyCatcher.forceActiveFocus()
        root.refreshPreviewDevice()
      })
    } else {
      clearPreview()
    }
  }

  onStreamingChanged: {
    if (streaming && opened) Qt.callLater(root.refreshPreviewDevice)
    else clearPreview()
  }

  Loader {
    id: previewBackendLoader
    active: root.previewRequested

    sourceComponent: Component {
      Item {
        id: previewBackend

        function refreshDevice() {
          root.clearPreview()
          if (!root.previewRequested) return

          var inputs = previewMediaDevices.videoInputs
          for (var index = 0; index < inputs.length; ++index) {
            if (root.isPreviewDevice(inputs[index])) {
              previewCamera.cameraDevice = inputs[index]
              root.previewDeviceAvailable = true
              return
            }
          }
        }

        MediaDevices {
          id: previewMediaDevices
          onVideoInputsChanged: previewBackend.refreshDevice()
        }

        Camera {
          id: previewCamera
          active: root.previewRequested && root.previewDeviceAvailable
          onErrorOccurred: root.previewHasFrames = false
        }

        CaptureSession {
          camera: previewCamera
          videoOutput: previewOutput
        }
      }
    }

    onLoaded: item.refreshDevice()
  }

  Connections {
    target: previewOutput.videoSink
    function onVideoFrameChanged(_frame) {
      if (!root.previewRequested || !root.previewDeviceAvailable) return
      root.previewLastFrameMs = Date.now()
      root.previewHasFrames = true
    }
  }

  Timer {
    interval: 750
    running: root.previewRequested && !root.previewDeviceAvailable
    repeat: true
    onTriggered: root.refreshPreviewDevice()
  }

  Timer {
    interval: 1000
    running: root.previewRequested
    repeat: true
    onTriggered: {
      if (root.previewHasFrames && Date.now() - root.previewLastFrameMs > 1750)
        root.previewHasFrames = false
    }
  }

  FileView {
    id: runtimeDirWatcher
    path: root.runtimeDir
    watchChanges: true
    printErrors: false
    onFileChanged: statusFile.reload()
  }

  FileView {
    id: statusFile
    path: root.statusPath
    watchChanges: true
    printErrors: false
    onLoaded: {
      missingStatusRefresh.stop()
      root.applyStatus(text())
    }
    onLoadFailed: missingStatusRefresh.restart()
    onFileChanged: reload()
  }

  Process {
    id: statusProcess
    command: [root.cliPath, "status"]

    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.applyStatus(text)
    }

    onExited: function(exitCode) {
      if (exitCode !== 0) {
        root.webcamStatus = {
          state: "error",
          reason: "status_command_failed",
          ready: false,
          service_enabled: root.serviceEnabled,
          service_active: false
        }
      }
    }
  }

  Process {
    id: actionProcess
    command: [root.cliPath, "status"]

    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: if (text.trim() !== "") root.applyStatus(text)
    }
    stderr: StdioCollector {
      waitForEnd: true
      onStreamFinished: if (text.trim() !== "") root.actionError = text.trim()
    }

    onExited: function(exitCode) {
      root.actionBusy = false
      if (exitCode !== 0) {
        root.desiredEnabled = null
        if (root.actionError === "") root.actionError = "DroidCam control command failed"
      }
      delayedRefresh.restart()
    }
  }

  Timer {
    interval: root.refreshIntervalSec * 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: root.checkLease()
  }

  Timer {
    id: delayedRefresh
    interval: 750
    repeat: false
    onTriggered: root.refresh()
  }

  Timer {
    id: missingStatusRefresh
    interval: 750
    repeat: false
    onTriggered: root.refresh()
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰄀"
    foreground: root.iconColor
    active: false
    dimmed: !root.displayEnabled || root.state === "waiting_device"
    tooltipText: root.tooltipText

    onPressed: function(buttonCode) {
      if (buttonCode === Qt.RightButton) {
        if (root.serviceEnabled) root.runAction("reconnect")
      } else if (buttonCode === Qt.MiddleButton) {
        root.refresh()
      } else {
        root.toggle()
      }
    }
  }

  KeyboardPanel {
    id: popup
    anchorItem: button
    owner: root
    bar: root.bar
    open: root.opened
    focusTarget: keyCatcher
    contentWidth: popup.fittedContentWidth(Style.space(370))
    contentHeight: popup.fittedContentHeight(content.implicitHeight)

    PanelKeyCatcher {
      id: keyCatcher
      anchors.fill: parent
      onMoveRequested: function(dx, dy) { root.moveCursor(dx, dy) }
      onActivateRequested: root.activateCursor()
      onCloseRequested: root.close()
      onTabRequested: function(direction) { root.switchPanel(direction) }
      onTextKey: function(text) {
        if ((text === "r" || text === "R") && root.serviceEnabled) root.runAction("reconnect")
        else if (text === "t" || text === "T") root.runAction("toggle")
      }

      Column {
        id: content
        width: parent.width
        spacing: Style.space(12)

        Item {
          id: header
          width: parent.width
          implicitHeight: hero.implicitHeight

          PanelHero {
            id: hero
            width: parent.width
            title: "iPhone Webcam"
            meta: root.statusText
            detail: root.streaming ? "LIVE" : ""
            foreground: root.foreground
            fontFamily: root.fontFamily
            iconOpacity: root.displayEnabled ? 1.0 : 0.5
            iconComponent: Component {
              Text {
                text: "󰄀"
                textFormat: Text.PlainText
                color: root.iconColor
                font.family: root.fontFamily
                font.pixelSize: Style.font.display
              }
            }
            trailingControl: Component {
              ToggleSwitch {
                checked: root.displayEnabled
                busy: root.actionBusy
                hasCursor: root.cursorIndex === 0
                foreground: hero.foreground
                onHovered: function(on) { if (on) root.cursorIndex = 0 }
                onToggled: root.runAction("toggle")

                PanelToolTip {
                  visible: parent.containsMouse
                  text: root.serviceEnabled ? "Disable auto-connect" : "Enable auto-connect"
                  fontFamily: hero.fontFamily
                }
              }
            }
          }
        }

        BorderSurface {
          id: previewSurface
          visible: root.previewRequested && root.previewHasFrames
          width: parent.width
          height: visible ? width * 9 / 16 : 0
          radius: Style.cornerRadius
          color: "black"
          borderSpec: Border.controlSpec("normal", root.foreground, Color.accent)
          clip: true

          VideoOutput {
            id: previewOutput
            anchors.fill: parent
            anchors.margins: 1
            fillMode: VideoOutput.PreserveAspectFit
            endOfStreamPolicy: VideoOutput.ClearOutput
            mirrored: false
          }
        }

        Text {
          width: parent.width
          text: root.actionError !== "" ? root.actionError : root.reasonText
          textFormat: Text.PlainText
          color: root.actionError !== "" || root.state === "error" || root.state === "conflict" ? root.urgent : root.dim
          font.family: root.fontFamily
          font.pixelSize: Style.font.bodySmall
          wrapMode: Text.WordWrap
        }

        Text {
          visible: root.clientErrorText !== "" && root.state !== "streaming"
          width: parent.width
          text: "Last client message: " + root.clientErrorText
          textFormat: Text.PlainText
          color: root.dim
          font.family: root.fontFamily
          font.pixelSize: Style.font.caption
          wrapMode: Text.WordWrap
        }

        PanelSeparator {
          width: parent.width
          foreground: root.foreground
        }

        PanelSectionHeader {
          text: "CONNECTION"
          foreground: root.foreground
          fontFamily: root.fontFamily
        }

        InfoPair {
          label: "Resolution"
          value: root.resolutionText
        }

        InfoPair {
          label: "Mode"
          value: "Video only"
        }

        ActionButton {
          width: parent.width
          label: root.actionBusy ? "Working…" : "Reconnect now"
          iconText: "󰑐"
          hasCursor: root.cursorIndex === 1
          enabled: root.serviceEnabled && !root.actionBusy
          onHovered: function(on) { if (on) root.cursorIndex = 1 }
          onClicked: root.runAction("reconnect")
        }
      }
    }
  }

  component InfoPair: RowLayout {
    id: infoPair
    property string label: ""
    property string value: ""

    width: parent ? parent.width : implicitWidth
    spacing: Style.space(8)

    Text {
      text: infoPair.label
      textFormat: Text.PlainText
      color: root.dim
      font.family: root.fontFamily
      font.pixelSize: Style.font.bodySmall
      Layout.alignment: Qt.AlignTop
    }

    Item { Layout.fillWidth: true }

    Text {
      text: infoPair.value
      textFormat: Text.PlainText
      color: root.foreground
      font.family: root.fontFamily
      font.pixelSize: Style.font.bodySmall
      horizontalAlignment: Text.AlignRight
      wrapMode: Text.WordWrap
      Layout.maximumWidth: Style.space(245)
    }
  }

  component ActionButton: BorderSurface {
    id: actionButton
    property string label: ""
    property string iconText: ""
    property bool hasCursor: false
    signal clicked()
    signal hovered(bool isHovered)

    implicitHeight: Style.space(42)
    radius: Style.cornerRadius
    color: (actionMouse.containsMouse || hasCursor) && enabled
      ? Style.hoverFillFor(root.foreground, Color.accent)
      : "transparent"
    borderSpec: Border.controlSpec(hasCursor ? "hover-cursor" : "normal", root.foreground, Color.accent)
    opacity: enabled ? 1.0 : 0.45

    Row {
      anchors.centerIn: parent
      spacing: Style.space(8)

      Text {
        text: actionButton.iconText
        textFormat: Text.PlainText
        color: root.foreground
        font.family: root.fontFamily
        font.pixelSize: Style.font.icon
      }

      Text {
        text: actionButton.label
        textFormat: Text.PlainText
        color: root.foreground
        font.family: root.fontFamily
        font.pixelSize: Style.font.body
        font.bold: true
      }
    }

    MouseArea {
      id: actionMouse
      anchors.fill: parent
      enabled: actionButton.enabled
      hoverEnabled: true
      cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
      onContainsMouseChanged: actionButton.hovered(containsMouse)
      onClicked: actionButton.clicked()
    }
  }
}
