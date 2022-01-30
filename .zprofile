# Start new session
# export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/.config
export XDG_RUNTIME_DIR=/tmp/$USER-runtime-dir
if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
	mkdir "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi
if [[ ! -a /tmp/cache ]]; then
	mkdir -p /tmp/cache
fi
if [[ ! -a $HOME/.cache/chromium ]]; then
	ln -s /dev/null $HOME/.cache/chromium
fi
if [[ ! -a /tmp/cache/mozilla ]]; then
	mkdir -p /tmp/cache/mozilla
fi
if [[ ! -a $HOME/.cache/mozilla ]]; then
	ln -s /tmp/cache/mozilla $HOME/.cache/mozilla
fi
if [[ $SSH_TTY ]]; then
	if [[ ! $TMUX ]]; then
		read "?Choose (t)mux, (z)sh: " SESSION_TYPE
		if [[ "$SESSION_TYPE" == "t" ]]; then
			exec tmux -2 -L ssh new-session -A -s ssh
		fi
	fi
elif [[ ! $TMUX && ! $DISPLAY && ! $WAYLAND_DISPLAY ]]; then
	read "?Choose (s)way, (h)ikari, (x)org, (t)mux, (z)sh: " SESSION_TYPE
	if [[ "$SESSION_TYPE" == "t" ]]; then
		if [[ ! $TMUX ]]; then
			exec tmux -2 -L pty new-session -A -s pty
		fi
	elif [[ "$SESSION_TYPE" == "s" ]]; then
		export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.sock
		export MESA_LOADER_DRIVER_OVERRIDE=crocus
		exec &> /tmp/sway.log
		exec seatd-launch sway
	elif [[ "$SESSION_TYPE" == "h" ]]; then
		export MESA_LOADER_DRIVER_OVERRIDE=crocus
		exec &> /tmp/hikari.log
		exec seatd-launch hikari
		# exec dbus-launch --sh-syntax --exit-with-session sway
	elif [[ "$SESSION_TYPE" == "x" ]]; then
		export MESA_LOADER_DRIVER_OVERRIDE=crocus
		exec &> /tmp/xorg.log
		exec startx
	fi
fi
