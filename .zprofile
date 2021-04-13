# SESSION_TYPE=/tmp/session_type
# if [[ (! -v TMUX) && (-v SSH_TTY) ]]; then
# 	exec tmux new-session -A -s remote
# elif [[ ! -f $SESSION_TYPE ]]; then
# 	exec start_session $SESSION_TYPE
# fi

if [[ $SSH_TTY ]]; then
	if [[ ! $TMUX ]]; then
		exec tmux new-session -A -s remote
	fi
elif [[ ! $TMUX && ! $DISPLAY && ! $WAYLAND_DISPLAY ]]; then
	read "?Choose (t)mux, (s)way, (x)org, (z)sh: " SESSION_TYPE

	if [[ "$SESSION_TYPE" == "t" ]]; then
		exec tmux new-session -A -s local
	elif [[ "$SESSION_TYPE" == "s" ]]; then
		export XDG_CONFIG_HOME=$HOME/.config
		export XDG_RUNTIME_DIR=/tmp/$USER-runtime-dir
		if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
			mkdir "$XDG_RUNTIME_DIR"
			chmod 0700 "$XDG_RUNTIME_DIR"
		fi
		exec sway
	elif [[ "$SESSION_TYPE" == "x" ]]; then
		exec startx
	fi
fi
