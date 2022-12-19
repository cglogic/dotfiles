# Start new session

# export LANG=en_US.UTF-8
export MPD_HOST=/var/mpd/socket
export QT_QPA_PLATFORMTHEME=qt5ct

export XDG_CONFIG_HOME="$HOME/.config"

export XDG_RUNTIME_DIR="/tmp/$USER-runtime-dir"
if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
	mkdir "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi

CACHE_DIR="$XDG_RUNTIME_DIR/cache"
if [[ ! -d "$CACHE_DIR" ]]; then
	mkdir -p "$CACHE_DIR"
	chmod 0700 "$CACHE_DIR"
fi
HOME_CACHE_DIR="$HOME/.cache"
if [[ ! -L "$HOME_CACHE_DIR" ]]; then
	rm -rf "$HOME_CACHE_DIR"
	ln -s "$CACHE_DIR" "$HOME_CACHE_DIR"
fi
CHROME_CACHE_DIR="$HOME_CACHE_DIR/chromium"
if [[ ! -L "$CHROME_CACHE_DIR" ]]; then
	rm -rf "$CHROME_CACHE_DIR"
	ln -s /dev/null "$CHROME_CACHE_DIR"
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
		export XDG_CURRENT_DESKTOP=sway
		export XDG_SESSION_DESKTOP=sway
		if [[ "$HOST" == "t440p" ]]; then
			export WLR_DRM_NO_ATOMIC=1
			# export MESA_LOADER_DRIVER_OVERRIDE=crocus
		fi
		exec &> $XDG_RUNTIME_DIR/sway.log
		exec seatd-launch sway
	elif [[ "$SESSION_TYPE" == "x" ]]; then
		if [[ "$HOST" == "t440p" ]]; then
			# export MESA_LOADER_DRIVER_OVERRIDE=crocus
		fi
		exec &> $XDG_RUNTIME_DIR/xorg.log
		exec startx
	elif [[ "$SESSION_TYPE" == "t" ]]; then
		if [[ ! $TMUX ]]; then
			exec tmux -2 -L pty new-session -A -s pty
		fi
	fi
fi
