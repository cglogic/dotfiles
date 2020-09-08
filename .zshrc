# zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt APPEND_HISTORY
# setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
# setopt NUMERIC_GLOB_SORT
setopt LIST_PACKED
unsetopt LIST_TYPES
unsetopt ALWAYS_LAST_PROMPT

umask 77

# Colors for completion
ZLS_COLORS="no=00:fi=00:di=34:ln=36:pi=33:so=35:bd=33:cd=33:ex=32:lc=\e[:rm=m:tc=00:sp=00:ma=07:hi=00:du=00:ow=34:tw=34:su=31:sg=31"

zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' insert-tab false

zle_highlight[(r)suffix:*]="suffix:fg=cyan"

# Aliases
alias h='history'
alias j='jobs -l'
alias la='ls -aF'
alias lf='ls -FA'
alias ll='ls -lAFh'
alias c='xclip -i -f -selection primary | xclip -i -selection clipboard'
alias v='xclip -o'

alias grep='grep --color=auto'
alias df='df -h'
alias dfc='dfc -d'
alias ps='ps -ww'
alias pstree='pstree -g 2'
alias tree='tree -N'

alias gdb='gdb91'
alias fsl='fossil'
alias svn='svnlite'

alias mpvrt='mpv --no-cache --demuxer-readahead-secs 0'
alias feh='feh -x -B black -N -.'
alias mupdf='mupdf-gl'
alias sxiv='sxiv -abrf -s d'
alias alarm='doas at -f ~/.bin/alarm.sh'
alias atop='atop -af 1'
alias nnn='nnn -e'

alias f='ag --nocolor -l -g "" | fzy -l 256 -p "❯ "'
alias e='ag --nocolor -l -g "" | fzy -l 256 -p "❯ " | xargs kak -e "delete-buffer *stdin*"'

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotls='dot ls-tree -r master --name-only'

# Environment variables
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

if [[ -d /usr/local/lib/qt5/bin ]]; then
	PATH=$PATH:/usr/local/lib/qt5/bin
fi

if [[ -d $HOME/.bin ]]; then
	PATH=$PATH:$HOME/.bin
fi

if [[ -d $HOME/depot_tools ]]; then
	PATH=$PATH:$HOME/depot_tools
fi

export -U PATH=$PATH

export EDITOR=kak
export PAGER=less

export BLOCKSIZE=K
export LSCOLORS=exgxfxdxcxdxdxbxbxexex
export CLICOLOR=

# export TOP=-CHP
export LESS=-SR

# export GREP_OPTIONS=--color=auto

export LESS_TERMCAP_xx=$'\033[0m'  # For stop coloring output of env
export LESS_TERMCAP_mb=$'\033[35m' # begin blinking
export LESS_TERMCAP_md=$'\033[33m' # begin bold
export LESS_TERMCAP_me=$'\033[0m'  # end mode
export LESS_TERMCAP_se=$'\033[0m'  # end standout-mode
export LESS_TERMCAP_so=$'\033[31m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\033[0m'  # end underline
export LESS_TERMCAP_us=$'\033[32m' # begin underline

export MANPAGER=less
export MANCOLOR=yes
export MANWIDTH=tty

if [[ -d $HOME/.man ]]; then
	export MANPATH=:$HOME/.man
fi

#export DISPLAY=:0
export SXHKD_SHELL=/bin/sh
export GIT_PAGER=cat
export MPD_HOST=/var/mpd/socket
export LYNX_CFG=$HOME/.lynx.cfg
#export PYTHONPATH=$HOME/lib/python

export NNN_COLORS='4231'
export NNN_RESTRICT_NAV_OPEN='1'

export FZF_DEFAULT_COMMAND='ag --nocolor -l -g ""'
export FZF_DEFAULT_OPTS='--exact'

CV=10
export CC=/usr/local/llvm$CV/bin/clang
export CXX=/usr/local/llvm$CV/bin/clang++
export CPP=/usr/local/llvm$CV/bin/clang-cpp
export LD=/usr/local/llvm$CV/bin/ld.lld
export AR=/usr/local/llvm$CV/bin/llvm-ar
export DB=/usr/local/llvm$CV/bin/lldb
export CF=/usr/local/llvm$CV/bin/clang-format
export CT=/usr/local/llvm$CV/bin/clang-tidy

export LD_LIBRARY_PATH=/usr/local/llvm$CV/lib

# Perform compinit only once a day.
autoload -Uz compinit
setopt EXTENDEDGLOB
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
	compinit
	$(touch -m $HOME/.zcompdump)
else
	compinit -C
fi
unsetopt EXTENDEDGLOB

# Execute code in the background to not affect the current session
{
	# Compile zcompdump, if modified, to increase startup speed.
	dump="$HOME/.zcompdump"
	if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
		zcompile "$dump"
	fi
} &!

# Create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    up-line-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  down-line-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# tcsh like auto completion
tcsh_autolist() {
	if [[ -z ${LBUFFER// } ]]; then
		BUFFER="ls " CURSOR=3 zle list-choices
	else
		zle expand-or-complete-prefix
	fi
}

zle -N tcsh_autolist
bindkey '^I' tcsh_autolist

# Update x11 window title
# if [[ $(tty) =~ "pts*" ]]; then
if [[ -v X11 || -v SSH_CONNECTION ]]; then
function precmd {
	print -Pn "\033]0;%n@%m:%~\007"
}
fi

# Custom prompt if we connected via ssh
if [[ -v SSH_CONNECTION ]]; then
	PROMPT="%F{magenta}%n%f@%F{blue}%m%f %F{cyan}%1~%f %(?,%F{red}❯,%F{green}❯)%F{yellow}❯%(?,%F{green}❯,%F{red}❯)%f "
elif [[ -v X11 ]]; then
	PROMPT="%F{cyan}%1~%f %(?,%F{red}❯,%F{green}❯)%F{yellow}❯%(?,%F{green}❯,%F{red}❯)%f "
else
	PROMPT="%F{cyan}%1~%f %(?,%F{red}>,%F{green}>)%F{yellow}>%(?,%F{green}>,%F{red}>)%f "
fi

# Run tmux if we connected via ssh
if [[ (! -v TMUX) && (-v SSH_TTY) ]]; then
	exec tmux new-session -A -s remote
fi

# zprof
