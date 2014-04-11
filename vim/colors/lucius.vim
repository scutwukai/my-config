" ============================================================================
" Name:     Lucius vim color scheme
" Author:   Jonathan Filip <jfilip1024@gmail.com>
" Version:  8.1.2
" ----------------------------------------------------------------------------
"
" Light and dark color scheme for GUI and 256 color terminal.
"
" There are several options available to customize the color scheme to your
" own tastes. This is particularly useful when you have to work in different
" environments at different times (home, work, day, night, etc).
"
" The GUI and 256 color terminal versions of this color scheme are identical.
"
" You can set up the color scheme by manually setting the options you want or
" by choosing one of the presets defined. These presets are loaded after you
" first source the color scheme file and are all commands that start with
" 'Lucius'.
"
" I have also started to create color schemes for different applications. I
" have been using them for PuTTY, iTerm2, and Visual Studio, but will keep
" adding more as I go along. You can find the files for these on Github:
"
" https://github.com/jonathanfilip/lucius
"
" You can also clone the following repository if you use Pathogen or something
" similar. It holds the vim color scheme in a 'colors' directory:
"
" https://github.com/jonathanfilip/vim-lucius
"
"
"
" Presets:
"
" There are several presets available that will set all the options for you.
" There are screenshots of each preset below:
"
" * LuciusDark (dark default): http://i.imgur.com/LsZbF.png
" * LuciusDarkHighContrast: http://i.imgur.com/e70i9.png
" * LuciusDarkLowContrast: http://i.imgur.com/Hmw8s.png
" * LuciusBlack: http://i.imgur.com/iD4ri.png
" * LuciusBlackHighContrast: http://i.imgur.com/lHvTJ.png
" * LuciusBlackLowContrast: http://i.imgur.com/oZLkg.png
"
" * LuciusLight (light default): http://i.imgur.com/soYD8.png
" * LuciusLightLowContrast: http://i.imgur.com/95I86.png
" * LuciusWhite: http://i.imgur.com/wDzkz.png
" * LuciusWhiteLowContrast: http://i.imgur.com/jlUf4.png
"
" To use the presets, you just need to set the color scheme first. In your
" vimrc, you can just do this:
"
" colorscheme lucius
" LuciusBlack
"
" You can still just set the background variable and then set the color
" scheme. This will default to LuciusDark for 'dark' and LuciusLight for
" 'light'.
"
"
" Options:
"
" The presets available cover most of the options. You can, however, customize
" things by setting the following variables yourself:
"
" g:lucius_style  (default: 'dark')
"
" Set this option to either 'light' or 'dark' for your desired color scheme.
" It has the same effect as setting the background.
"
" g:lucius_contrast  (default: 'normal')
"
" This option determines the contrast to use for text/ui elements. It can be
" set to 'low', 'normal', or 'high'. At this time there is no 'high' for the
" light scheme.
"
" g:lucius_contrast_bg  (default: 'normal')
"
" Setting this option makes the background a higher contrast. Current settings
" are 'normal' and 'high'.
"
" g:lucius_use_bold (default: 1)
"
" Setting this will cause the color scheme to use bold fonts for some items.
"
" g:lucius_use_underline (default: 1)
"
" Setting this will cause the color scheme to use underlined fonts for some
" items.
"
" ============================================================================



" ============================================================================
" Options:
" ============================================================================

unlet! g:colors_name
hi clear
if exists("syntax_on")
    syntax reset
endif

if exists("g:lucius_style")
    let s:style = g:lucius_style
else
    let s:style = &background
endif

if exists("g:lucius_contrast")
    let s:contrast = g:lucius_contrast
else
    let s:contrast = "normal"
endif

if exists("g:lucius_contrast_bg")
    let s:contrast_bg = g:lucius_contrast_bg
else
    let s:contrast_bg = "normal"
endif

if exists("g:lucius_use_bold")
    let s:use_bold = g:lucius_use_bold
else
    let s:use_bold = 1
endif

if exists("g:lucius_use_underline")
    let s:use_underline = g:lucius_use_underline
else
    let s:use_underline = 1
endif


let s:normal_items = [
            \ "ColorColumn", "Comment", "Constant", "Cursor", "CursorColumn",
            \ "CursorIM", "CursorLine", "CursorLineNr", "DiffAdd", "DiffChange",
            \ "DiffDelete", "Directory", "Error", "ErrorMsg", "Identifier",
            \ "IncSearch", "LineNr", "MatchParen", "ModeMsg", "MoreMsg",
            \ "NonText", "Pmenu", "PmenuSbar", "PmenuSel",
            \ "PmenuThumb", "PreProc", "Question", "Search", "SignColumn",
            \ "Special", "SpecialKey", "Statement", "StatusLineNC", "TabLine",
            \ "TabLineFill", "Todo", "Type", "VertSplit", "Visual",
            \ "WarningMsg", "WildMenu",
            \ ]

let s:bold_items = [
            \ "DiffText", "FoldColumn", "Folded", "StatusLine", "TabLineSel",
            \ "Title",
            \ ]

let s:underline_items = [
            \ "Underlined", "VisualNOS"
            \ ]

let s:undercurl_items = [
            \ "SpellBad", "SpellCap", "SpellLocal", "SpellRare"
            \ ]


" ============================================================================
" Color Definitions:
" ============================================================================

" ----------------------------------------------------------------------------
" 'Normal' Colors:
" ----------------------------------------------------------------------------

hi clear Normal
hi Normal gui=none cterm=none term=none

if s:style == "light"
    if s:contrast == "high"
        hi Normal       ctermfg=16
    elseif s:contrast == "low"
        hi Normal       ctermfg=241
    else
        hi Normal       ctermfg=238
    endif
else
    if s:contrast == "high"
        hi Normal       ctermfg=255
    elseif s:contrast == "low"
        hi Normal       ctermfg=250
    else
        hi Normal       ctermfg=188
    endif
endif

if s:style == "light"
    if s:contrast_bg == "high"
        hi Normal                       ctermbg=231
    else
        hi Normal                       ctermbg=255
    endif
else
    if s:contrast_bg == "high"
        hi Normal                       ctermbg=16
    else
        hi Normal                       ctermbg=236
    endif
endif



" ----------------------------------------------------------------------------
" Extra setup
" ----------------------------------------------------------------------------

exec "set background=" . s:style

" Clear default settings
for s:item in s:normal_items + s:bold_items + s:underline_items + s:undercurl_items
    exec "hi " . s:item . " ctermfg=NONE ctermbg=NONE gui=none"
                \ . " ctermfg=NONE ctermbg=NONE cterm=none term=none"
endfor

let g:colors_name="lucius"


" ----------------------------------------------------------------------------
" Text Markup:
" ----------------------------------------------------------------------------

hi ModeMsg      ctermfg=fg
hi Question     ctermfg=fg
if s:style == "light"
    hi NonText      ctermfg=146
    hi SpecialKey   ctermfg=151
    if s:contrast == "low"
        hi Comment      ctermfg=247
        hi Constant     ctermfg=172
        hi Directory    ctermfg=36
        hi Identifier   ctermfg=34
        hi PreProc      ctermfg=37
        hi Special      ctermfg=127
        hi Statement    ctermfg=32
        hi Title        ctermfg=32
        hi Type         ctermfg=31
    else
        hi Comment      ctermfg=244
        hi Constant     ctermfg=130
        hi Directory    ctermfg=29
        hi Identifier   ctermfg=28
        hi PreProc      ctermfg=30
        hi Special      ctermfg=90
        hi Statement    ctermfg=25
        hi Title        ctermfg=25
        hi Type         ctermfg=24
    endif
else
    hi NonText      ctermfg=60
    hi SpecialKey   ctermfg=65
    if s:contrast == "low"
        hi Comment      ctermfg=242
        hi Constant     ctermfg=144
        hi Directory    ctermfg=108
        hi Identifier   ctermfg=107
        hi PreProc      ctermfg=72
        hi Special      ctermfg=139
        hi Statement    ctermfg=74
        hi Title        ctermfg=38
        hi Type         ctermfg=73
    elseif s:contrast == "high"
        hi Comment      ctermfg=245
        hi Constant     ctermfg=203
        hi Number       ctermfg=208
        hi Directory    ctermfg=194
        hi Identifier   ctermfg=79
        hi PreProc      ctermfg=117
        hi Special      ctermfg=225
        hi Statement    ctermfg=178
        hi Title        ctermfg=117
        hi Type         ctermfg=87
    else
        hi Comment      ctermfg=244
        hi Constant     ctermfg=187
        hi Directory    ctermfg=151
        hi Identifier   ctermfg=150
        hi PreProc      ctermfg=115
        hi Special      ctermfg=182
        hi Statement    ctermfg=117
        hi Title        ctermfg=74
        hi Type         ctermfg=116
    endif
endif


" ----------------------------------------------------------------------------
" Highlighting:
" ----------------------------------------------------------------------------

hi Cursor       ctermfg=bg
hi CursorColumn ctermfg=NONE
hi CursorIM     ctermfg=bg
hi CursorLine   ctermfg=NONE
hi Visual       ctermfg=NONE
hi VisualNOS    ctermfg=fg        ctermbg=NONE
if s:style == "light"
    hi CursorColumn                 ctermbg=253
    hi CursorLine                   ctermbg=253
    hi IncSearch    ctermfg=fg        ctermbg=80
    hi MatchParen   ctermfg=NONE      ctermbg=80
    hi Search       ctermfg=fg        ctermbg=214
    hi Visual                       ctermbg=153
    if s:contrast == "low"
        hi Cursor                       ctermbg=110
        hi CursorIM                     ctermbg=110
        hi Error        ctermfg=160   ctermbg=224
        hi Todo         ctermfg=136   ctermbg=229
    else
        hi Cursor                       ctermbg=67
        hi CursorIM                     ctermbg=67
        hi Error        ctermfg=124   ctermbg=181
        hi Todo         ctermfg=94   ctermbg=229
    endif
else
    hi CursorColumn                 ctermbg=238
    hi CursorLine                   ctermbg=236
    hi IncSearch    ctermfg=bg
    hi MatchParen   ctermfg=bg
    hi Search       ctermfg=bg
    hi Visual                       ctermbg=24
    if s:contrast == "low"
        hi Cursor                       ctermbg=67
        hi CursorIM                     ctermbg=67
        hi Error        ctermfg=167   ctermbg=88
        hi IncSearch                    ctermbg=37
        hi MatchParen                   ctermbg=107
        hi Search                       ctermbg=172
        hi Todo         ctermfg=142   ctermbg=58
    elseif s:contrast == "high"
        hi Cursor                       ctermbg=153
        hi CursorIM                     ctermbg=153
        hi Error        ctermfg=217   ctermbg=124
        hi IncSearch                    ctermbg=123
        hi MatchParen                   ctermbg=108
        hi Search                       ctermbg=215
        hi Todo         ctermfg=228   ctermbg=101
    else
        hi Cursor                       ctermbg=110
        hi CursorIM                     ctermbg=110
        hi Error        ctermfg=210   ctermbg=88
        hi IncSearch                    ctermbg=80
        hi MatchParen                   ctermbg=149
        hi Search                       ctermbg=172
        hi Todo         ctermfg=185   ctermbg=58
    endif
endif


" ----------------------------------------------------------------------------
" Messages:
" ----------------------------------------------------------------------------

hi ModeMsg      ctermfg=fg
hi Question     ctermfg=fg
if s:style == "light"
    if s:contrast == "low"
        hi ErrorMsg     ctermfg=160
        hi MoreMsg      ctermfg=33
        hi WarningMsg   ctermfg=172
    else
        hi ErrorMsg     ctermfg=124
        hi MoreMsg      ctermfg=26
        hi WarningMsg   ctermfg=130
    endif
else
    if s:contrast == "low"
        hi ErrorMsg     ctermfg=167
        hi MoreMsg      ctermfg=37
        hi WarningMsg   ctermfg=137
    elseif s:contrast == "high"
        hi ErrorMsg     ctermfg=210
        hi MoreMsg      ctermfg=123
        hi WarningMsg   ctermfg=216
    else
        hi ErrorMsg     ctermfg=203
        hi MoreMsg      ctermfg=80
        hi WarningMsg   ctermfg=173
    endif
endif


" ----------------------------------------------------------------------------
" UI:
" ----------------------------------------------------------------------------

hi ColorColumn  ctermfg=NONE
hi Pmenu        ctermfg=bg
hi PmenuSel     ctermfg=fg
hi PmenuThumb   ctermfg=fg
hi StatusLine   ctermfg=bg
hi TabLine      ctermfg=bg
hi TabLineSel   ctermfg=fg
hi WildMenu     ctermfg=fg
if s:style == "light"
    hi ColorColumn                  ctermbg=187
    hi CursorLineNr ctermfg=247   ctermbg=253
    hi FoldColumn                   ctermbg=250
    hi Folded                       ctermbg=250
    hi LineNr       ctermfg=247   ctermbg=253
    hi PmenuSel                     ctermbg=153
    hi SignColumn                   ctermbg=252
    hi StatusLineNC ctermfg=254
    hi TabLineFill  ctermfg=249
    hi VertSplit    ctermfg=254
    hi WildMenu                     ctermbg=153
    if s:contrast == "low"
        hi FoldColumn   ctermfg=244
        hi Folded       ctermfg=244
        hi Pmenu                        ctermbg=247
        hi PmenuSbar    ctermfg=247   ctermbg=241
        hi PmenuThumb                   ctermbg=247
        hi SignColumn   ctermfg=244
        hi StatusLine                   ctermbg=247
        hi StatusLineNC                 ctermbg=247
        hi TabLine                      ctermbg=247
        hi TabLineFill                  ctermbg=247
        hi TabLineSel                   ctermbg=153
        hi VertSplit                    ctermbg=247
    else
        hi FoldColumn   ctermfg=241
        hi Folded       ctermfg=241
        hi Pmenu                        ctermbg=244
        hi PmenuSbar    ctermfg=244   ctermbg=238
        hi PmenuThumb                   ctermbg=247
        hi SignColumn   ctermfg=241
        hi StatusLine                   ctermbg=244
        hi StatusLineNC                 ctermbg=244
        hi TabLine                      ctermbg=244
        hi TabLineFill                  ctermbg=244
        hi TabLineSel                   ctermbg=153
        hi VertSplit                    ctermbg=244
    endif
else
    hi ColorColumn                  ctermbg=101
    hi CursorLineNr ctermfg=241   ctermbg=238
    hi FoldColumn                   ctermbg=239
    hi Folded                       ctermbg=239
    hi LineNr       ctermfg=244   ctermbg=238
    hi PmenuSel                     ctermbg=24
    hi SignColumn                   ctermbg=239
    hi StatusLineNC ctermfg=238
    hi TabLineFill  ctermfg=238
    hi VertSplit    ctermfg=241
    hi WildMenu                     ctermbg=24
    if s:contrast == "low"
        hi FoldColumn   ctermfg=248
        hi Folded       ctermfg=248
        hi Pmenu                        ctermbg=245
        hi PmenuSbar    ctermfg=245   ctermbg=250
        hi PmenuThumb                   ctermbg=240
        hi SignColumn   ctermfg=245
        hi StatusLine                   ctermbg=245
        hi StatusLineNC                 ctermbg=245
        hi TabLine                      ctermbg=245
        hi TabLineFill                  ctermbg=245
        hi TabLineSel                   ctermbg=24
        hi VertSplit                    ctermbg=245
    elseif s:contrast == "high"
        hi FoldColumn   ctermfg=251
        hi Folded       ctermfg=251
        hi Pmenu                        ctermbg=250
        hi PmenuSbar    ctermfg=250   ctermbg=253
        hi PmenuThumb                   ctermbg=245
        hi SignColumn   ctermfg=250
        hi StatusLine                   ctermbg=250
        hi StatusLineNC                 ctermbg=250
        hi TabLine                      ctermbg=250
        hi TabLineFill                  ctermbg=250
        hi TabLineSel                   ctermbg=31
        hi VertSplit                    ctermbg=250
    else
        hi FoldColumn   ctermfg=250
        hi Folded       ctermfg=250
        hi Pmenu                        ctermbg=249
        hi PmenuSbar    ctermfg=249   ctermbg=252
        hi PmenuThumb                   ctermbg=244
        hi SignColumn   ctermfg=249
        hi StatusLine                   ctermbg=249
        hi StatusLineNC                 ctermbg=249
        hi TabLine                      ctermbg=249
        hi TabLineFill                  ctermbg=249
        hi TabLineSel                   ctermbg=24
        hi VertSplit                    ctermbg=249
    endif
endif


" ----------------------------------------------------------------------------
" Diff:
" ----------------------------------------------------------------------------

hi DiffAdd      ctermfg=fg
hi DiffChange   ctermfg=fg
hi DiffDelete   ctermfg=fg

if s:style == "light"
    hi DiffAdd                      ctermbg=151
    hi DiffChange                   ctermbg=187
    hi DiffDelete                   ctermbg=181
    hi DiffText                     ctermbg=187
    if s:contrast == "low"
        hi DiffText     ctermfg=208
    else
        hi DiffText     ctermfg=166
    endif
else
    hi DiffAdd                      ctermbg=65
    hi DiffChange                   ctermbg=101
    hi DiffDelete                   ctermbg=95
    hi DiffText                     ctermbg=101
    if s:contrast == "low"
        hi DiffText     ctermfg=185
    else
        hi DiffText     ctermfg=228
    endif
endif


" ----------------------------------------------------------------------------
" Spelling:
" ----------------------------------------------------------------------------

if s:style == "light"
    hi SpellBad     guisp=#d70000
    hi SpellCap     guisp=#00afd7
    hi SpellLocal   guisp=#d7af00
    hi SpellRare    guisp=#5faf00
else
    hi SpellBad     guisp=#d70000
    hi SpellCap     guisp=#00afd7
    hi SpellLocal   guisp=#d7af00
    hi SpellRare    guisp=#5faf00
endif


" ----------------------------------------------------------------------------
" Miscellaneous:
" ----------------------------------------------------------------------------

hi Ignore       ctermfg=bg
hi Underlined   ctermfg=fg


" ============================================================================
" Text Emphasis:
" ============================================================================

if s:use_bold == 1
    for s:item in s:bold_items
        exec "hi " . s:item . " gui=bold cterm=bold term=none"
    endfor
endif

if s:use_underline == 1
    for s:item in s:underline_items
        exec "hi " . s:item . " gui=underline cterm=underline term=none"
    endfor
    for s:item in s:undercurl_items
        exec "hi " . s:item . " cterm=underline"
    endfor
endif

for s:item in s:undercurl_items
    exec "hi " . s:item . " gui=undercurl term=none"
endfor


" ============================================================================
" Cterm Colors:
" ============================================================================



" ============================================================================
" Plugin Specific Colors:
" ============================================================================

" Tagbar:
hi link TagbarAccessPublic Constant
hi link TagbarAccessProtected Type
hi link TagbarAccessPrivate PreProc

" Vimwiki:
hi link VimwikiHeader1 BIdentifier
hi link VimwikiHeader2 BPreProc
hi link VimwikiHeader3 BStatement
hi link VimwikiHeader4 BSpecial
hi link VimwikiHeader5 BConstant
hi link VimwikiHeader6 BType


" ============================================================================
" Preset Commands:
" ============================================================================

function! SetLucius(style, contrast, contrast_bg)
    let g:lucius_style = a:style
    let g:lucius_contrast = a:contrast
    let g:lucius_contrast_bg = a:contrast_bg
endfunction

command! LuciusLight call SetLucius("light", "normal", "normal")
            \ | colorscheme lucius
command! LuciusLightLowContrast call SetLucius("light", "low", "normal")
            \ | colorscheme lucius
command! LuciusLightHighContrast call SetLucius("light", "high", "normal")
            \ | colorscheme lucius

command! LuciusWhite call SetLucius("light", "normal", "high")
            \ | colorscheme lucius
command! LuciusWhiteLowContrast call SetLucius("light", "low", "high")
            \ | colorscheme lucius
command! LuciusWhiteHighContrast call SetLucius("light", "high", "high")
            \ | colorscheme lucius

command! LuciusDark call SetLucius("dark", "normal", "normal")
            \ | colorscheme lucius
command! LuciusDarkLowContrast call SetLucius("dark", "low", "normal")
            \ | colorscheme lucius
command! LuciusDarkHighContrast call SetLucius("dark", "high", "normal")
            \ | colorscheme lucius

command! LuciusBlack call SetLucius("dark", "normal", "high")
            \ | colorscheme lucius
command! LuciusBlackLowContrast call SetLucius("dark", "low", "high")
            \ | colorscheme lucius
command! LuciusBlackHighContrast call SetLucius("dark", "high", "high")
            \ | colorscheme lucius

" vim: tw=78

