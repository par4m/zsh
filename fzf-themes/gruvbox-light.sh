# Base16 Gruvbox Material Light, Soft
# Author: Mayush Kumar (https://github.com/MayushKumar), sainnhe (https://github.com/sainnhe/gruvbox-material-vscode)

_gen_fzf_default_opts() {

local color00='#f2e5bc'
local color01='#ebdbb2'
local color02='#c9b99a'
local color03='#a89984'
local color04='#665c54'
local color05='#654735'
local color06='#3c3836'
local color07='#282828'
local color08='#c14a4a'
local color09='#c35e0a'
local color0A='#b47109'
local color0B='#6c782e'
local color0C='#4c7a5d'
local color0D='#45707a'
local color0E='#945e80'
local color0F='#e78a4e'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts




