# Start new session

# export LANG=en_US.UTF-8
export MPD_HOST=/var/mpd/socket
export QT_QPA_PLATFORMTHEME=qt5ct

# webcam power save
CAM=`doas usbconfig list | grep "Camera" | cut -f 1 -d ":"`
if [ -n $CAM ]; then
	doas usbconfig -d $CAM suspend
fi

export XDG_CONFIG_HOME="$HOME/.config"

export XDG_RUNTIME_DIR="/tmp/$USER-runtime-dir"
if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
	mkdir "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi

# CACHE="$XDG_RUNTIME_DIR/cache"
# if [[ ! -a "$CACHE" ]]; then
# 	mkdir -p "$CACHE"
# 	chmod 0700 "$CACHE"
# fi
if [[ ! -a "$HOME/.cache/chromium" ]]; then
	ln -s /dev/null "$HOME/.cache/chromium"
fi

if [[ $SSH_TTY ]]; then
	if [[ ! $TMUX ]]; then
		read "?Choose (t)mux, (z)sh: " SESSION_TYPE
		if [[ "$SESSION_TYPE" == "t" ]]; then
			exec tmux -2 -L ssh new-session -A -s ssh
		fi
	fi
elif [[ ! $TMUX && ! $DISPLAY && ! $WAYLAND_DISPLAY ]]; then
	SP_FILE=~/.session_prev
	if [[ -f "$SP_FILE" ]]; then
		SESSION_PREV=`cat $SP_FILE`
		if [[ "$SESSION_PREV" == "s" ]]; then
			SESSION_PROMPT="?Choose [s]way, (x)org, (t)mux, (z)sh: "
		elif [[ "$SESSION_PREV" == "x" ]]; then
			SESSION_PROMPT="?Choose (s)way, [x]org, (t)mux, (z)sh: "
		elif [[ "$SESSION_PREV" == "t" ]]; then
			SESSION_PROMPT="?Choose (s)way, (x)org, [t]mux, (z)sh: "
		elif [[ "$SESSION_PREV" == "z" ]]; then
			SESSION_PROMPT="?Choose (s)way, (x)org, (t)mux, [z]sh: "
		else
			SESSION_PREV="z"
			SESSION_PROMPT="?Choose (s)way, (x)org, (t)mux, (z)sh: "
		fi
	else
		SESSION_PROMPT="?Choose (s)way, (x)org, (t)mux, (z)sh: "
	fi
	read "$SESSION_PROMPT" SESSION_TYPE
	if [[ "$SESSION_TYPE" == "" ]]; then
		SESSION_TYPE="$SESSION_PREV"
	fi
	if [[ "$SESSION_TYPE" != "" ]]; then
		echo "$SESSION_TYPE" > "$SP_FILE"
	fi
	if [[ "$SESSION_TYPE" == "s" ]]; then
		export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.sock
		export MESA_LOADER_DRIVER_OVERRIDE=crocus
		export XDG_CURRENT_DESKTOP=sway
		export WLR_DRM_NO_ATOMIC=1
		exec &> /tmp/sway.log
		exec seatd-launch sway
	elif [[ "$SESSION_TYPE" == "x" ]]; then
		export MESA_LOADER_DRIVER_OVERRIDE=crocus
		exec &> /tmp/xorg.log
		exec startx
	elif [[ "$SESSION_TYPE" == "t" ]]; then
		if [[ ! $TMUX ]]; then
			exec tmux -2 -L pty new-session -A -s pty
		fi
	fi
fi
