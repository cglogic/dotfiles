# zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# bindkey -v

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

# if [[ -v WAYLAND_DISPLAY ]]; then
# 	# termcap for foot
# 	export TERMCAP="${TERM}:bw:hs:ds=\E]2;\E\\:fs=\E\\:kb=\177:ts=\E]2;:vb=\E]555\E\\:tc=${TERM}:"
# fi

zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' insert-tab false

zle_highlight[(r)suffix:*]="suffix:fg=cyan"

# Environment variables
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

USER_BIN=$HOME/.local/bin
if [[ -d $USER_BIN ]]; then
	if [[ -v PATH ]] && [[ "" != $PATH ]]; then
		PATH=$PATH:$USER_BIN
	else
		PATH=$USER_BIN
	fi
fi

export -U PATH=$PATH

export EDITOR=kak
export PAGER=less

export BLOCKSIZE=K
export LSCOLORS=exgxfxdxcxdxdxbxbxexex
export CLICOLOR=

# export TOP=-CHP
export LESS=-SRF

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

USER_MAN=$HOME/.local/man
if [[ -d $USER_MAN ]]; then
	export MANPATH=$MANPATH:$USER_MAN
fi

# export GIT_PAGER=cat
export MPD_HOST=/var/mpd/socket
#export PYTHONPATH=$HOME/lib/python

export NNN_COLORS='4231'
export NNN_RESTRICT_NAV_OPEN='1'

export FZF_DEFAULT_COMMAND='ag --nocolor -l -g ""'
export FZF_DEFAULT_OPTS='--exact'

# export DEV_STACK=gnu
if [[ -v DEV_STACK ]] && [[ $DEV_STACK = llvm ]]; then
	LLVM_VER=19
	LLVM_PATH=/usr/local/llvm$LLVM_VER/bin
	if [[ -d $LLVM_PATH ]]; then
		export CC=$LLVM_PATH/clang
		export CXX=$LLVM_PATH/clang++
		export CPP=$LLVM_PATH/clang-cpp
		export LD=$LLVM_PATH/ld.lld
		export AR=$LLVM_PATH/llvm-ar
		export DB=$LLVM_PATH/lldb
		export CF=$LLVM_PATH/clang-format
		export CT=$LLVM_PATH/clang-tidy
	fi
elif [[ -v DEV_STACK ]] && [[ $DEV_STACK = gnu ]]; then
	GCC_VER=13
	BIN_PATH=/usr/local/bin
	if [[ -d /usr/local/lib/gcc$GCC_VER ]]; then
		export CC=$BIN_PATH/gcc$GCC_VER
		export CXX=$BIN_PATH/g++$GCC_VER
		export CPP=$BIN_PATH/cpp$GCC_VER
		export CPP=$BIN_PATH/cpp$GCC_VER
		export LD=$BIN_PATH/ld.gold
		export AS=$BIN_PATH/as
		export AR=$BIN_PATH/ar
		export DB=$BIN_PATH/gdb
	fi
# else
# 	export CC=clang
# 	export CXX=clang++
# 	export CPP=clang-cpp
# 	export LD=ld
# 	export AR=llvm-ar
# 	export DB=lldb
fi

USER_LIB=$HOME/.local/lib
if [[ -d $USER_LIB ]]; then
	if [[ -v LD_LIBRARY_PATH ]] && [[ "" != $LD_LIBRARY_PATH ]]; then
		LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$USER_LIB
	else
		LD_LIBRARY_PATH=$USER_LIB
	fi
fi

if [[ -v LD_LIBRARY_PATH ]]; then
	export -U LD_LIBRARY_PATH=$LD_LIBRARY_PATH
fi

# Aliases
alias h='history'
alias j='jobs -l'
alias la='ls -aF'
alias lf='ls -FA'
alias ll='ls -lAFh'
alias sh='ENV=$HOME/.shrc; export ENV; sh'
alias f='ag --nocolor -l -g "" | fzy -l 256 -p "❯ "'
alias e='ag --nocolor -l -g "" | fzy -l 256 -p "❯ " | xargs kak -e "delete-buffer *stdin*"'
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotls='dot ls-tree -r master --name-only'

if [ "$WAYLAND_DISPLAY" ]; then
	alias img='swayimg'
	alias pdf='zathura'
	alias c='wl-copy'
	alias p='wl-paste'
elif [ "$DISPLAY" ]; then
	alias img='nsxiv -abrf -s d'
	alias pdf='mupdf'
	alias c='xclip -i -f -selection primary | xclip -i -selection clipboard'
	alias p='xclip -o'
fi

alias fsl='fossil'
alias tm='tmux -L local new-session -A -s local'
# alias tmx='tmux -L x11 new-session -A -s x11'
# alias tmg='tmux -L gui new-session -A -s gui'
alias tms='tmux -L ssh new-session -A -s ssh'
alias tmp='tmux -L pty new-session -A -s pty'
# alias tmr='if [[ ! $TMUX ]]; then tmux -2 new-session -A -s $( if [[ $WAYLAND_DISPLAY || $DISPLAY ]]; then echo gui; else echo pty; fi ); fi'
alias vim='nvim'
alias ssh='TERM=xterm-256color ssh'
alias grep='grep --color=auto'
alias df='df -hT'
alias dfc='dfc -d'
alias ps='ps -ww'
alias pstree='pstree -g 2'
alias tree='tree -N'
alias cbonsai='cbonsai -l -i'
alias cmatrix='cmatrix -u 6 -C green'
alias mpvrt='mpv --no-cache --demuxer-readahead-secs 0'
alias alarm='doas at -f ~/.bin/alarm.sh'
alias atop='atop -af 1'
alias nnn='nnn -xedC'
alias trafshow='trafshow -R 1'
# alias tmux='if [[ ! $TMUX ]]; then tmux -2; fi'

alias replace='() { find $1 -type f -exec sed -i "" -e "s/$2/$3/g" {} \;}'

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

# Update window title
if [[ -v SSH_CONNECTION ]]; then
	# title="\033]0;%n@%m:%~\007"
	title="\033]0;%n@%m:%1~\007"
else
	# title="\033]0;%~\007"
	title="\033]0;%1~\007"
fi
if [[ -v WAYLAND_DISPLAY || -v DISPLAY || -v SSH_CONNECTION ]]; then
	function precmd {
		print -Pn $title
		# if [[ -v title ]]; then
		# 	print -Pn $title
		# fi
	}
fi

# Custom prompt
if [[ -v WAYLAND_DISPLAY || -v DISPLAY ]]; then
	PROMPT="%F{cyan}%1~%f %(?,%F{red}❯,%F{green}❯)%F{yellow}❯%(?,%F{green}❯,%F{red}❯)%f "
elif [[ -v SSH_CONNECTION ]]; then
	PROMPT="%F{magenta}%n%f@%F{blue}%m%f %F{cyan}%1~%f %(?,%F{red}❯,%F{green}❯)%F{yellow}❯%(?,%F{green}❯,%F{red}❯)%f "
else
	PROMPT="%F{cyan}%1~%f %(?,%F{red}>,%F{green}>)%F{yellow}>%(?,%F{green}>,%F{red}>)%f "
fi

autoload -U zmv

# zprof
