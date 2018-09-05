# $FreeBSD: stable/10/share/skel/dot.cshrc 266029 2014-05-14 15:23:06Z bdrewery $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

alias h		history 25
alias j		jobs -l
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAFh
alias c		xclip -i
alias v		xclip -o

#alias grep	grep --color=auto
alias df	df -h
alias dfc	dfc -d
alias ps	ps -ww
alias pstree	pstree -g 2

alias gdb	gdb81
alias fsl	fossil

alias mpvrt	mpv --no-cache --demuxer-readahead-secs 0
alias feh	feh -x -B black -N -.
alias mupdf	mupdf-gl
alias sxiv	sxiv -abrf -s d
alias alarm	at -f ~/bin/alarm.sh

alias dot	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
alias dotls	dot ls-tree -r master --name-only

# These are normally set through /etc/login.conf.  You may override them here
# if wanted.
set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin /usr/local/lib/qt5/bin)
# setenv	BLOCKSIZE	K
# A righteous umask
umask 77

setenv	EDITOR		kak
setenv	PAGER		less
setenv	BLOCKSIZE       K
setenv	LSCOLORS 	ExGxFxdxCxDxDxBxBxExEx
setenv	CLICOLOR

#setenv	TOP		-CHP
setenv	LESS		-S
setenv	GREP_OPTIONS	--color=auto

setenv	MANCOLOR	yes
setenv	MANWIDTH	tty

setenv	DISPLAY			:0
setenv	SXHKD_SHELL		/bin/sh
setenv	GIT_PAGER		cat
setenv	MPD_HOST		/var/mpd/socket
setenv	LD_LIBRARY_PATH		/usr/local/llvm60/lib
setenv	LYNX_CFG		$HOME/.lynx.cfg
#setenv	PYTHONPATH		$HOME/lib/python

#setenv	FZF_DEFAULT_COMMAND	"find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed s/^..//"
setenv	FZF_DEFAULT_COMMAND	'ag --nocolor -l -g ""'
setenv	FZF_DEFAULT_OPTS	'--exact'

setenv	CV	60
setenv	CC	/usr/local/llvm$CV/bin/clang
setenv	CXX	/usr/local/llvm$CV/bin/clang++
setenv	CPP	/usr/local/llvm$CV/bin/clang-cpp
setenv	LD	/usr/local/llvm$CV/bin/ld.lld

if ($?prompt) then
	if (($?SSH_CLIENT || $?SSH_TTY) && $TERM != "screen" && $TERM != "screen-256color" && ! $?TMUX) then
		exec tmux -2 new-session -A -s remote;
	endif

	#if ($TERM != "rxvt" && $TERM != "rxvt-256color" && $TERM != "screen" && $TERM != "screen-256color" && ! $?TMUX) then
		#if ($?SSH_CLIENT || $?SSH_TTY) then
			#exec tmux -2 new-session -A -s remote;
		#else
			#set ttyn = `tty | awk '{split($0,a,"/"); print a[3]}'`
			#exec tmux -f ~/.tmux_local.conf -L local new-session -A -s $ttyn;
		#endif
	#endif

	# An interactive shell -- set some stuff up
	#set prompt = "%N@%m:%~ %# "
	#if ( $TERM =~ "*-256color" ) then
		#set prompt = "%{\033[38;5;034m%}%N%{\033[38;5;251m%}@%{\033[38;5;037m%}%m%{\033[38;5;251m%}:%{\033[38;5;172m%}%~ %{\033[38;5;127m%}%#%{\033[0m%} "
	#else
		#set prompt = "%{\033[32m%}%N%{\033[37m%}@%{\033[36m%}%m%{\033[37m%}:%{\033[33m%}%~ %{\033[35m%}%#%{\033[0m%} "
	#endif
	set prompt = "%{\033[32m%}%N%{\033[37m%}@%{\033[36m%}%m%{\033[37m%}:%{\033[33m%}%~ %{\033[35m%}%#%{\033[0m%} "
	set promptchars = "%#"

	set filec
	set history = 1000
	set savehist = (1000 merge)
	set autolist = ambiguous
	set histfile = ~/.history
	# Use history to aid expansion
	set autoexpand
	set autorehash
	set mail = (/var/mail/$USER)
	set complet all
	#set autocorrect
	set nobeep
	set matchbeep = nomatch
	#set correct = cmd
	set color

	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward

		#bindkey "^[[C" forward-char		# Cursor right
		#bindkey "^[[D" backward-char		# Cursor left
		#bindkey "^[[A" up-history		# Cursor up
		#bindkey "^[[B" down-history		# Cursor down
		bindkey "^[^[[D" backward-word		# Alt Cursor left
		bindkey "^[^[[C" forward-word		# Alt Cursor right

		bindkey "\e[1~" beginning-of-line	# Home
		bindkey "\e[2~" overwrite-mode		# Ins
		bindkey "\e[3~" delete-char		# Delete
		bindkey "\e[4~" end-of-line		# End
		bindkey "\e[5~" up-history		# PageUp
		bindkey "\e[6~" down-history		# PageDown
	endif
endif
