local ls = require 'luasnip'

local s = ls.parser.parse_snippet

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,
  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

ls.snippets = {
  lua = {
    s('lf', 'local $1 = function($2)\n  $0\nend'),
  },
  javascript = {
    s('cl', "console.log($0)"),
    s('imp', "import ${2:moduleName} from '${1:module}'$0"),
    s('imd', "import { $2 } from '${1:module}'$0"),
    s('req', "const ${1:packageName} = require('${1:package}')$0"),
    s('mde', "module.exports = {\n\t$0\n}\n"),
    s('edf', "export const ${1:functionName} = (${2:params}) => {\n\t$0\n}\n"),
    s('con', "constructor(${1:params}) {\n\t${0}\n}"),
    s('met', "${1:methodName}(${2:params}) {\n\t${0}\n}"),
    s('fof', "for (const ${1:item} of ${2:object}) {\n\t${0}\n}"),
    s('fin', "for (const ${1:item} in ${2:object}) {\n\t${0}\n}"),
    s('dob', "const {${2:propertyName}} = ${1:objectToDestruct}"),
    s('dar', "const [${2:propertyName}] = ${1:arrayToDestruct}"),
    s('sti', "setInterval(() => {\n\t${2}\n}, ${0:intervalInms})"),
    s('sto', "setTimeout(() => {\n\t${2}\n}, ${1:delayInms})"),
    s('prom', "return new Promise((resolve, reject) => {\n\t${1}\n})"),
  },
  go = {
    s('pln', 'fmt.Println($0)'),
    s('f', 'func $1($2) $3 {\n  $0\n}'),
  }
}

vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/dotfiles/nvim/.config/nvim/lua/merlijn/config/luasnip.lua<CR>')
