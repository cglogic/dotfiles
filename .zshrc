HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt HIST_IGNORE_DUPS
# setopt autocd autopushd

umask 77

# Colors for completion
ZLS_COLORS="no=00:fi=00:di=01;34:ln=01;36:\
pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:\
ex=01;32:lc=\e[:rm=m:tc=00:sp=00:ma=07:hi=00:du=00"

zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}

# Aliases
# alias h='history 25'
alias j='jobs -l'
alias la='ls -aF'
alias lf='ls -FA'
alias ll='ls -lAFh'
alias c='xclip -i'
alias v='xclip -o'

#alias grep='grep --color=auto'
alias df='df -h'
alias dfc='dfc -d'
alias ps='ps -ww'
alias pstree='pstree -g 2'
alias tree='tree -N'

alias gdb='gdb821'
alias fsl='fossil'
alias svn='svnlite'

alias mpvrt='mpv --no-cache --demuxer-readahead-secs 0'
alias feh='feh -x -B black -N -.'
alias mupdf='mupdf-gl'
alias sxiv='sxiv -abrf -s d'
alias alarm='doas at -f ~/.bin/alarm.sh'
alias atop='atop -af 1'

alias f='ag --nocolor -l -g "" | fzy -l 256 -p "❯ "'
alias e='ag --nocolor -l -g "" | fzy -l 256 -p "❯ " | xargs kak -e "delete-buffer *stdin*"'

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotls='dot ls-tree -r master --name-only'

# Environment variables
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/.bin:/usr/local/lib/qt5/bin

export EDITOR=kak
export PAGER=less

export BLOCKSIZE=K
export LSCOLORS=ExGxFxdxCxDxDxBxBxExEx
export CLICOLOR

# export TOP=-CHP
export LESS=-SR

export GREP_OPTIONS=--color=auto

export MANPAGER=less

export LESS_TERMCAP_xx=$'\033[0m'  # For stop coloring output of env
export LESS_TERMCAP_mb=$'\033[35m' # begin blinking
export LESS_TERMCAP_md=$'\033[33m' # begin bold
export LESS_TERMCAP_me=$'\033[0m'  # end mode
export LESS_TERMCAP_se=$'\033[0m'  # end standout-mode
export LESS_TERMCAP_so=$'\033[31m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\033[0m'  # end underline
export LESS_TERMCAP_us=$'\033[32m' # begin underline

export MANPATH=:$HOME/.man
export MANCOLOR=yes
export MANWIDTH=tty

#export DISPLAY=:0
export SXHKD_SHELL=/bin/sh
export GIT_PAGER=cat
export MPD_HOST=/var/mpd/socket
export LYNX_CFG=$HOME/.lynx.cfg
#export PYTHONPATH=$HOME/lib/python

export NNN_CONTEXT_COLORS='4231'
export NNN_RESTRICT_NAV_OPEN='1'
export NNN_USE_EDITOR='1'

#export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed s/^..//"
export FZF_DEFAULT_COMMAND='ag --nocolor -l -g ""'
export FZF_DEFAULT_OPTS='--exact'

CV=80
export CC=/usr/local/llvm$CV/bin/clang
export CXX=/usr/local/llvm$CV/bin/clang++
export CPP=/usr/local/llvm$CV/bin/clang-cpp
export LD=/usr/local/llvm$CV/bin/ld.lld
export AR=/usr/local/llvm$CV/bin/llvm-ar
export DB=/usr/local/llvm$CV/bin/lldb
export CF=/usr/local/llvm$CV/bin/clang-format
export CT=/usr/local/llvm$CV/bin/clang-tidy

export LD_LIBRARY_PATH=/usr/local/llvm$CV/lib

# Autoloads
autoload -Uz compinit && compinit
autoload -U promptinit && promptinit
autoload -U colors && colors

# zstyle :compinstall filename '/home/gor/.zshrc'

# create a zkbd compatible hash;
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

unsetopt always_last_prompt

# Update x11 window title
wht=`tty`
function precmd {
	if [[ $wht =~ "pts*" ]]; then
		print -Pn "\033]0;${USER}@${HOST}:%~\007"
	fi
}

# Custom prompt if we connected via ssh
if [[ -v SSH_CONNECTION ]]; then
	PROMPT="%{$fg[red]%}$USER$reset_color@%{$fg[yellow]%}$HOST %{$fg[cyan]%}%1~$reset_color %{$fg[red]%}❯%{$fg[yellow]%}❯%{$fg[green]%}❯$reset_color "
elif [[ $wht =~ "pts*" ]]; then
	PROMPT="%{$fg[cyan]%}%1~$reset_color %{$fg[red]%}❯%{$fg[yellow]%}❯%{$fg[green]%}❯$reset_color "
else
	PROMPT="%{$fg[cyan]%}%1~$reset_color %{$fg[red]%}>%{$fg[yellow]%}>%{$fg[green]%}>$reset_color "
fi

# Run tmux if we connected via ssh
if [[ (! -v TMUX) && (-v SSH_TTY) ]]; then
	exec tmux -2 new-session -A -s remote
fi
