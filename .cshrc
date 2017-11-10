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

alias df	df -h
alias dfc	dfc -d

#alias gdb		gdb80
#alias gcc		gcc7
#alias ld		ld.lld
#alias clang		clang50
#alias clang++		clang++50
#alias clang-cpp		clang-cpp50
#alias lldb		lldb50
#alias python		python3
#alias mpv		mpv --fs
alias feh		feh -x -B black -N -.
alias mupdf		mupdf-gl
alias sxiv		sxiv -abfr -s d
alias dot		git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
alias dotls		git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME ls-tree -r master --name-only

# These are normally set through /etc/login.conf.  You may override them here
# if wanted.
set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin /usr/local/lib/qt5/bin)
# setenv	BLOCKSIZE	K
# A righteous umask
umask 77

setenv	EDITOR		vim
setenv	PAGER		less
setenv	BLOCKSIZE       K
setenv	LSCOLORS 	ExGxFxdxCxDxDxBxBxExEx
setenv	CLICOLOR

#setenv	TOP		-CHP
setenv	LESS		-S
setenv	GREP_OPTIONS	--color=auto

setenv	GIT_PAGER		cat
setenv	DISPLAY			:0
setenv	SXHKD_SHELL		/bin/sh
setenv	MPD_HOST		/var/mpd/socket
setenv	LD_LIBRARY_PATH		/usr/local/llvm50/lib
setenv	LYNX_CFG		$HOME/.lynx.cfg
setenv	FZF_DEFAULT_COMMAND	'ag --nocolor -l -g ""'
setenv	FZF_DEFAULT_OPTS	'--exact'

setenv	CC	/usr/local/llvm50/bin/clang
setenv	CXX	/usr/local/llvm50/bin/clang++
setenv	CPP	/usr/local/llvm50/bin/clang-cpp
setenv	LD	/usr/local/llvm50/bin/ld.lld

if ($?prompt) then
	if (($?SSH_CLIENT || $?SSH_TTY) && $TERM != "screen" && $TERM != "screen-256color" && ! $?TMUX) then
		exec tmux -f ~/.tmux_remote.conf -2 -L remote new-session -A -s remote;
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
	set prompt = "%{\033[32m%}%N%{\033[37m%}@%{\033[36m%}%m%{\033[37m%}:%{\033[33m%}%~ %{\033[35m%}%#%{\033[37m%} "
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
