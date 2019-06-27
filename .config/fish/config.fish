set fish_greeting
umask 77

set -gx PATH /sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/.bin /usr/local/lib/qt5/bin

set -gx EDITOR	kak
set -gx PAGER	less

set -gx BLOCKSIZE	K
set -gx LSCOLORS	exgxfxdxcxdxdxbxbxexex
set -gx CLICOLOR

# set -gx TOP -CHP
set -gx LESS	-SR

set -gx GREP_OPTIONS	--color=auto

set -gx MANPAGER less

set -gx LESS_TERMCAP_mb (printf "\033[35m") # begin blinking
set -gx LESS_TERMCAP_md (printf "\033[33m") # begin bold
set -gx LESS_TERMCAP_me (printf "\033[0m")  # end mode
set -gx LESS_TERMCAP_se (printf "\033[0m")  # end standout-mode
set -gx LESS_TERMCAP_so (printf "\033[31m") # begin standout-mode - info box
set -gx LESS_TERMCAP_ue (printf "\033[0m")  # end underline
set -gx LESS_TERMCAP_us (printf "\033[32m") # begin underline

set -gx LESS_TERMCAP_xx (printf "\033[0m") # For stop coloring output of env

set -gx MANPATH		:$HOME/.man
set -gx MANCOLOR	yes
set -gx MANWIDTH	tty

#set -gx DISPLAY		:0
set -gx SXHKD_SHELL	/bin/sh
set -gx GIT_PAGER	cat
set -gx MPD_HOST	/var/mpd/socket
set -gx LYNX_CFG	$HOME/.lynx.cfg
#set -gx PYTHONPATH	$HOME/lib/python

set -gx NNN_CONTEXT_COLORS '4231'
set -gx NNN_RESTRICT_NAV_OPEN '1'
set -gx NNN_USE_EDITOR '1'

#set -gx FZF_DEFAULT_COMMAND	"find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed s/^..//"
set -gx FZF_DEFAULT_COMMAND	'ag --nocolor -l -g ""'
set -gx FZF_DEFAULT_OPTS	'--exact'

set -gx CV	80
set -gx CC	/usr/local/llvm$CV/bin/clang
set -gx CXX	/usr/local/llvm$CV/bin/clang++
set -gx CPP	/usr/local/llvm$CV/bin/clang-cpp
set -gx LD	/usr/local/llvm$CV/bin/ld.lld
set -gx AR	/usr/local/llvm$CV/bin/llvm-ar
set -gx DB	/usr/local/llvm$CV/bin/lldb
set -gx CF	/usr/local/llvm$CV/bin/clang-format

set -gx LD_LIBRARY_PATH	/usr/local/llvm$CV/lib

if status is-login
and not set -q TMUX
and set -q SSH_TTY
	exec tmux -2 new-session -A -s remote
end
