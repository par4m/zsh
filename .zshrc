# export ZDOTDIR=$HOME/.config/zsh
# source "$HOME/.config/zsh/.zshrc"
#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
export ZSH_COMPDUMP=$ZDOTDIR/cache/.zcompdump-$HOST
export DISABLE_AUTO_TITLE='true'
DISABLE_AUTO_TITLE="true"
export TERM=tmux-256color
# export FZF_DEFAULT_OPTS=''
export FZF_DEFAULT_OPTS='--height 50% --layout=default --border'
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


# completions
autoload -Uz compinit -i -d "$ZSH_COMPDUMP"
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
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "Aloxaf/fzf-tab"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
# zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions





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

# FZF 
# TODO update for mac
# [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
# [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
# [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
# [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

if [[ -n ${ZSH_COMPDUMP}(#qN.mh+24) ]]; then
	compinit -i -d "$ZSH_COMPDUMP";
else
	compinit -C -d "$ZSH_COMPDUMP";
fi;

# Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# zoxide to be at the end of zshrc 
eval "$(zoxide init zsh)"
