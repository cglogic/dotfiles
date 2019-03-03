set fish_greeting

set -gx PATH /sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/.bin /usr/local/lib/qt5/bin

set -gx EDITOR	kak
set -gx PAGER	less

set -gx BLOCKSIZE	K
set -gx LSCOLORS	ExGxFxdxCxDxDxBxBxExEx
set -gx CLICOLOR

# set -gx TOP -CHP
set -gx LESS	-SR

set -gx GREP_OPTIONS	--color=auto

set -gx MANPAGER	most
set -gx MANPATH		:$HOME/.man
set -gx MANCOLOR	yes
set -gx MANWIDTH	tty

#set -gx DISPLAY		:0
set -gx SXHKD_SHELL	/bin/sh
set -gx GIT_PAGER	cat
set -gx MPD_HOST	/var/mpd/socket
set -gx LYNX_CFG	$HOME/.lynx.cfg
#set -gx PYTHONPATH	$HOME/lib/python

#set -gx FZF_DEFAULT_COMMAND	"find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed s/^..//"
set -gx FZF_DEFAULT_COMMAND	'ag --nocolor -l -g ""'
set -gx FZF_DEFAULT_OPTS	'--exact'

set -gx CV	70
set -gx CC	/usr/local/llvm$CV/bin/clang
set -gx CXX	/usr/local/llvm$CV/bin/clang++
set -gx CPP	/usr/local/llvm$CV/bin/clang-cpp
set -gx LD	/usr/local/llvm$CV/bin/ld.lld

set -gx LD_LIBRARY_PATH	/usr/local/llvm$CV/lib

if status is-login
and not set -q TMUX
and set -q SSH_TTY
	exec tmux -2 new-session -A -s remote
end
