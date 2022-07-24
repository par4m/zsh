# export ZDOTDIR=$HOME/.config/zsh
# source "$HOME/.config/zsh/.zshrc"
#!/bin/sh
zmodload zsh/zprof
export ZDOTDIR=$HOME/.config/zsh
export ZPLUGDIR=$ZDOTDIR/plugins
export ZSH_COMPDUMP=$ZDOTDIR/cache/.zcompdump-$HOST
export DISABLE_AUTO_TITLE='true'
DISABLE_AUTO_TITLE="true"
export TERM=tmux-256color
# export FZF_DEFAULT_OPTS=''
export FZF_DEFAULT_OPTS='--height 70% --layout=default --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix --follow --exclude .git'
export _ZO_FZF_OPTS='--height 60% --layout=default --border'


mkdir -p $ZDOTDIR/cache
HISTFILE=~/.zsh_history
setopt appendhistory

skip_global_compinit=1
# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP


# Test
function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}


# Clone and compile to wordcode missing plugins.
# zsh-syntax-highlighting
if [[ ! -e $ZPLUGDIR/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZPLUGDIR/zsh-syntax-highlighting
  zcompile-many $ZPLUGDIR/zsh-syntax-highlighting/{zsh-syntax-highlighting.zsh,highlighters/*/*.zsh}
fi
# zsh-autosuggestions
if [[ ! -e $ZPLUGDIR/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZPLUGDIR/zsh-autosuggestions
  zcompile-many $ZPLUGDIR/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi
# powerlevel10k
if [[ ! -e $ZPLUGDIR/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZPLUGDIR/powerlevel10k
  make -C $ZPLUGDIR/powerlevel10k pkg
fi




# Activate Powerlevel10k Instant Prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# completions
autoload -Uz compinit -i -d "$ZSH_COMPDUMP"
[[ "$ZSH_COMPDUMP".zwc -nt "$ZSH_COMPDUMP" ]] || zcompile-many "$ZSH_COMPDUMP"
unfunction zcompile-many

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.



# Highlight styles
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
# zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "Aloxaf/fzf-tab"
# zsh_add_plugin "zsh-users/zsh-autosuggestions"
# zsh_add_plugin "zsh-users/zsh-completions"
# zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions


# fzf-tab settings
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'exa -1 --color=always $realpath'
# zstyle ':fzf-tab:complete:*' popup-pad 0 0 # set a bigger width to the popup win
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-pad 10
# use tmux popup windows for completion
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


# Key-bindings
# bindkey -s '^o' 'ranger^M'
# bindkey -s '^f' 'zi^M'
# bindkey -s '^s' 'ncdu^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
# bindkey -r "^u"
bindkey -r "^d"



if [[ -n ${ZSH_COMPDUMP}(#qN.mh+24) ]]; then
	compinit -i -d "$ZSH_COMPDUMP";
else
	compinit -C -d "$ZSH_COMPDUMP";
fi;

# Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line


source $ZPLUGDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZPLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZPLUGDIR/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/p10k.zsh
source $ZDOTDIR/fzf-themes/gruvbox-light.sh

# zoxide to be at the end of zshrc 
eval "$(zoxide init zsh)"

