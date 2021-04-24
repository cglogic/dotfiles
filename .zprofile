# Start new session
if [[ $SSH_TTY ]]; then
	if [[ ! $TMUX ]]; then
		read "?Choose (t)mux, (z)sh: " SESSION_TYPE
		if [[ "$SESSION_TYPE" == "t" ]]; then
			exec tmux -2 -L ssh new-session -A -s ssh
		fi
	fi
elif [[ ! $TMUX && ! $DISPLAY && ! $WAYLAND_DISPLAY ]]; then
	read "?Choose (s)way, (x)org, (t)mux, (z)sh: " SESSION_TYPE
	if [[ "$SESSION_TYPE" == "t" ]]; then
		if [[ ! $TMUX ]]; then
			exec tmux -2 -L pty new-session -A -s pty
		fi
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
