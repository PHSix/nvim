local vim = vim
local api = vim.api
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

vim.o.termguicolors=true
local bg0         = '#212733'
local bg1         = '#242B48'
local bg2         = '#343F4C'
local dark0       = '#374D51'
local dark1       = '#212733'
local white       = '#dff9fb'
local red         = '#ee5253'
local darkred     = '#b33939'
local green       = '#BBE67E'
local darkgreen   = '#218c74'
local purple      = '#D4BFFF'
local lightblue   = '#34ace0'
local blue        = '#227093'
local darkblue    = '#474787'
local darker_blue = '#2c2c54'
local orange      = '#ff793f'
local darkorange  = '#cd6133'
local lightyellow = '#ffeaa7'
local yellow      = '#ffb142'
local darkyellow  = '#cc8e35'
local gray        = '#84817a'

local highlight_group = {
  -- default
  {group = 'Normal',              bg=bg0, fg=lightyellow},
  -- detail
  {group = 'MatchParen',          bg=bg0, fg=white, style='underline'},
  {group = 'CursorLine',          bg=bg2},
  {group = 'VertSplit',           bg=darker_blue, fg=darker_blue},
  {group = 'StatusLine',          bg=bg0, fg=darker_blue},
  {group = 'StatusLineNC',        bg=bg0, fg=darker_blue},
  -- LineNumber
  {group = 'LineNr',              fg=dark0},
  -- Folder
  {group = 'Folded',              bg=bg2, fg=green, styple='bold'},
  {group = 'FoldColumn',          bg=bg2, fg=green, styple='bold'},
  -- Sign
  {group = 'SignColumn',          bg=dark1},
  {group = 'EndOfBuffer',         fg=dark1},
  -- Git
  {group = 'GitAdd',              fg=darkgreen},
  {group = 'GitDelete',           fg=darkred},
  {group = 'GitChange',           fg=blue},
  -- Msg
  {group = 'ErrorMsg',            fg=bg0, bg=red},
  {group = 'WarningMsg',          fg=yellow, bg=bg0},
  {group = 'Hint',                fg=bg0, bg=orange},
  {group = 'Information',         fg=orange},
  -- syntax
  -- Contant
  {group = 'Character',           fg=purple},
  {group = 'Number',              fg=orange},
  {group = 'String',              fg=green},
  {group = 'Booleans',            fg=purple},
  {group = 'Float',               fg=lightblue},
  -- Indentifier
  {group = 'Function',            fg=orange, style="bold"},
  -- Statement
  {group = 'Conditinal',          fg=orange},
  {group = 'Repeat',              fg=orange, cfg=167},
  {group = 'Label',               fg=orange},
  {group = 'Operator',            fg=lightblue, ctermfg=1},
  {group = 'Keyword',             fg=orange},
  {group = 'Exception',           fg=orange},
  -- PreProc
  {group = 'Include',             fg=lightblue},
  {group = 'Defind',              fg=lightblue},
  {group = 'Marco',               fg=lightblue},
  {group = 'PreCondit',           fg=lightblue},
  -- Type
  {group = 'StorageClass',        fg=lightblue},
  {group = 'Structure',           fg=lightblue},
  {group = 'Typedef',             fg=lightblue},
  -- Special
  {group = 'SpecialChar',         fg=lightblue},
  {group = 'Tag',                 fg=lightblue},
  {group = 'Delimiter',           fg=lightblue},
  {group = 'SpecialComment',      fg=lightblue},
  {group = 'Debug',               fg=lightblue},
  -- nvim-tree
  {group = 'NvimTreeFolderName',  fg=yellow},
  {group = 'NvimTreeRootFolder',  fg=yellow},
  {group = 'NvimTreeSpecialFile', fg=yellow},
  -- nvim-bufferline
  -- dashboard
  {group = 'dashboardHeader',     fg=yellow},
  {group = 'dashboardFooter',     fg=darkorange},
  {group = 'dashboardCenter',     fg=darkgreen},
  {group = 'dashboardShortCut',   fg=darkorange},
  -- Pmenu
  {group = 'Pmenu',               bg=bg2},
  {group = 'PmenuSel',            bg=bg1, style='bold'},
  {group = 'PmenuSBar',           bg=bg2, fg=bg2},
  {group = 'PmenuThumb',          bg=gray},
  -- Search
  {group = 'Search',              fg=purple,bg=darkgreen},
  {group = 'MatchParen',          fg=white, bg=darkgreen},
  -- Visual
  {group = 'Visual',              style='inverse'},
  {group = 'VisualNOS',           bg=gray,},
  -- More
  {group='More', fg=lightblue},
  {group='MoreMsg', fg=lightblue},
  -- Mode
  {group='ModeMsg', fg=lightblue},
  {group='Statements', fg="#40ffff"}
}
local link_group = {
  -- barbar.nvim
  {'BufferTabpageFill',                    'Normal'},
  {'BufferTabpages',                       'Normal'},
  -- lspconfig
  -- {'LspDiagnosticsDefaultError',           'ErrorMsg'},
  {'LspDiagnosticsVirtualTextError',       'ErrorMsg'},
  {'LspDiagnosticsDefaultWarning',         'WarningMsg'},
  {'LspDiagnosticsDefaultHint',            'Hint'},
  {'LspDiagnosticsVirtualTextInformation', 'Information'},
  -- gitgutter
  {'GitGutterAdd',                         'GitAdd'},
  {'GitGutterChange',                      'GitChange'},
  {'GitGutterDelete',                      'GitDelete'},
  -- nvim-treesitter
  {'TSConstBuiltin','Constant'},
  {'TSConstructor  ','Typedef'},
  {'TSFuncBuiltin  ', 'Function'},
  {'TSStringEscape ', 'Character'},
  {'TSStringRegex  ', 'SpecialChar'},
  {'TSURI', 'Tag'},
  {'TSVariableBuiltin','Identifier'},

}
local value_group = {
  {'gitgutter_sign_added', '▊'},
  {'gitgutter_sign_modified', '▊'},
  {'gitgutter_sign_modified_removed', '▊'},
  {'gitgutter_sign_removed', '▊'},
  {'gitgutter_sign_removed_above_and_below', '▊'},
  {'gitgutter_sign_removed_first_line', '▊'},
  {'gitgutter_map_keys', 0}
}

local Set_Color =  function(group)
  for _, value in pairs(group) do
    if value['bg'] == nil then
      value['bg'] = 'NONE'
    end
    if value['fg'] == nil then
      value['fg'] = 'NONE'
    end
    if value['style'] == nil and value['cfg'] == nil then
      vim.cmd('hi! ' .. value["group"] .. " guibg=" .. value['bg'] .. " guifg=" .. value['fg'])
    elseif value['style'] ~= nil and value['cfg'] == nil then
      vim.cmd('hi! ' .. value["group"] .. " guibg=" .. value['bg'] .. " guifg=" .. value['fg'] .. ' gui=' .. value['style'])
    elseif value['style'] == nil and value['cfg'] ~= nil then
      vim.cmd('hi! ' .. value["group"] .. " guibg=" .. value['bg'] .. " guifg=" .. value['fg'] .. ' ctermfg=' .. value['cfg'])
    else
      vim.cmd('hi! ' .. value["group"] .. " guibg=" .. value['bg'] .. " guifg=" .. value['fg'] .. ' gui=' .. value['style'] .. " ctermfg=" .. value['cfg'])
    end
  end
end
local Link_group = function(group)
  for _, value in pairs(group) do
    vim.cmd('hi! link ' .. value[1] .. " " .. value[2])
  end
end

local Set_g_value = function (group)
  for _, v in pairs(group) do
    vim.g[v[1]] = v[2]
  end
end
Set_g_value(value_group)
Set_Color(highlight_group)
Link_group(link_group)
