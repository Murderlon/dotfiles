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
    -- import/export
    s('imp', "import ${2:moduleName} from '${1:module}'$0"),
    s('imd', "import { $2 } from '${1:module}'$0"),
    s('req', "const ${2:packageName} = require('${1:package}')$0"),
    s('edf', "export const ${1:functionName} = (${2:params}) => {\n\t$0\n}\n"),
    s('mde', "module.exports = {\n\t$0\n}\n"),
    -- log
    s('cl', "console.log($0)"),
    -- class
    s('class', "class ${1:name} {\n\tconstructor(${2:arguments}) {\n\t\t${0}\n\t}\n}"),
    s('con', "constructor(${1:params}) {\n\t${0}\n}"),
    s('met', "${1:methodName}(${2:params}) {\n\t${0}\n}"),
    -- loop
    s('fof', "for (const ${1:item} of ${2:object}) {\n\t${0}\n}"),
    s('fin', "for (const ${1:item} in ${2:object}) {\n\t${0}\n}"),
    -- vars
    s('dob', "const { ${2:propertyName} } = ${1:objectToDestruct}"),
    s('dar', "const [${2:propertyName}] = ${1:arrayToDestruct}"),
    -- functions
    s('sti', "setInterval(() => {\n\t${2}\n}, ${0:intervalInms})"),
    s('sto', "setTimeout(() => {\n\t${2}\n}, ${1:delayInms})"),
    s('prom', "return new Promise((resolve, reject) => {\n\t${1}\n})"),
    -- conditions
    s('if', "if (${1:condition}) {\n\t${0}\n}"),
    s('else', "else {\n\t${0}\n}"),
    s('switch', "switch (${1:expr}) {\n\tcase ${2:value}:\n\t\treturn $0;\n\tdefault:\n\t\treturn;\n}"),
    s('try', "try {\n\t${0}\n} catch (${1:err}) {\n\t\n}"),
    -- arrays
    s('map', "${1}.map((${2:item}) => {\n\t${0}\n})"),
    s('reduce', "${1}.reduce((${2:previous}, ${3:current}) => {\n\t${0}\n}${4:, initial})"),
    s('filter', "${1}.filter(${2:item} => {\n\t${0}\n})"),
    -- testing
    s('describe', "describe('${1:Name of the group}', () => {\n\t$0\n})"),
    s('beforeEach', "beforeEach(() => {\n\t$0\n})"),
    s('it', "it('${1:should }', () => {\n\t$0\n})"),
    s('eq', "expect($1).toEqual($0)"),
  },
  go = {
    s('pln', 'fmt.Println($0)'),
    s('f', 'func $1($2) $3 {\n  $0\n}'),
  }
}

vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/dotfiles/nvim/.config/nvim/lua/merlijn/config/luasnip.lua<CR>')
