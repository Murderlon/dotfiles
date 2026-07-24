import type {
  ExtensionAPI,
  ExtensionContext,
} from "@earendil-works/pi-coding-agent";
import { execFileSync } from "node:child_process";

const LIGHT_THEME = process.env.PI_MACOS_LIGHT_THEME ?? "light";
const DARK_THEME = process.env.PI_MACOS_DARK_THEME ?? "dark";
const POLL_MS = Number(process.env.PI_MACOS_THEME_POLL_MS ?? 5000);

function macOSAppearance(): "light" | "dark" {
  try {
    const value = execFileSync(
      "defaults",
      ["read", "-g", "AppleInterfaceStyle"],
      {
        encoding: "utf8",
        stdio: ["ignore", "pipe", "ignore"],
      },
    ).trim();

    return value === "Dark" ? "dark" : "light";
  } catch {
    // In light mode, AppleInterfaceStyle is usually unset and `defaults read` exits non-zero.
    return "light";
  }
}

function applyTheme(ctx: ExtensionContext, state: { activeTheme?: string }) {
  if (!ctx.hasUI) return;

  const nextTheme = macOSAppearance() === "dark" ? DARK_THEME : LIGHT_THEME;
  if (state.activeTheme === nextTheme) return;

  const result = ctx.ui.setTheme(nextTheme);
  if (result.success) {
    state.activeTheme = nextTheme;
  } else {
    ctx.ui.notify(
      `macOS auto-theme failed: ${result.error ?? `unknown theme ${nextTheme}`}`,
      "warning",
    );
  }
}

export default function (pi: ExtensionAPI) {
  let interval: ReturnType<typeof setInterval> | undefined;
  const state: { activeTheme?: string } = {};

  pi.on("session_start", async (_event, ctx) => {
    applyTheme(ctx, state);

    if (interval) clearInterval(interval);
    interval = setInterval(() => applyTheme(ctx, state), POLL_MS);
    interval.unref?.();
  });

  pi.on("session_shutdown", async () => {
    if (interval) clearInterval(interval);
    interval = undefined;
  });
}
