return {
  "L3MON4D3/LuaSnip",
  opts = function(_, _)
    local project_root = vim.fn.expand("~/code/cognition-evals")
    if vim.fn.getcwd() ~= project_root then
      return
    end

    local ls = require("luasnip")
    local s = ls.snippet
    local i = ls.insert_node
    local fmta = require("luasnip.extras.fmt").fmta

    ls.add_snippets("json", {
      s(
        "classical",
        fmta(
          [[
{
  "type": "classical",
  "criterion": "<>",
  "tests": {
    "files": {
      "<>": "<>"
    }
  },
  "weight": 3<>,
  "blocker": true,
  "rationale": "<>"
},
]],
          { i(1), i(2), i(3), i(4), i(5) }
        )
      ),
      s(
        "classical-reverse",
        fmta(
          [[
{
  "type": "classical",
  "criterion": "<>",
  "tests": {
    "reverse_test": {
      "test_files_globs": [
        "<>"
      ]
    }
  },
  "weight": 3<>,
  "blocker": true<>,
  "rationale": "<>"
},
]],
          { i(1), i(2), i(3), i(4), i(5) }
        )
      ),
      s(
        "classical-git",
        fmta(
          [[
{
  "type": "classical",
  "criterion": "<>",
  "tests": {
    "checkout": {
      "commit": "<>",
      "files": [
        "<>"
      ]
    }
  },
  "blocker": true,
  "weight": 3<>,
  "rationale": "<>"
},
]],
          { i(1), i(2), i(3), i(4), i(5) }
        )
      ),
      s(
        "prompt",
        fmta(
          [[
{
  "type": "prompt",
  "criterion": "<>",
  "blocker": false,
  "weight": 1<>,
  "rationale": "<>"
},
]],
          { i(1), i(2), i(3) }
        )
      ),
      s(
        "scope",
        fmta(
          [[
{
  "type": "scope",
  "weight": 2<>,
  "rationale": "<>",
  "files": [
    {
      "rule": "<>",
      "paths": [
        "<>"
      ]
    }
  ]
},
]],
          { i(1), i(2), i(3), i(4) }
        )
      ),
      s(
        "agentic",
        fmta(
          [[
{
  "type": "agentic",
  "setup": {
    "files": {
      "<>": "<>"
    },
    "commands": [
      "<>"
    ]
  },
  "steps": [
    "<>"
  ],
  "weight": 3<>,
  "blocker": true,
  "rationale": "<>"
},
]],
          { i(1), i(2), i(3), i(4), i(5), i(6) }
        )
      ),
      s(
        "scope-max",
        fmta(
          [[
{
  "type": "scope",
  "size": [
    {
      "max_net_lines": 50<>,
      "paths": [
        "<>"
      ]
    }
  ],
  "blocker": false,
  "weight": 2<>,
  "rationale": "<>"
},
]],
          { i(1), i(2), i(3), i(4) }
        )
      ),
    })
  end,
}
