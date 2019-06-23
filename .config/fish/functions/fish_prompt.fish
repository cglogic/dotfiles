function fish_prompt
	test $SSH_CONNECTION
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)(set_color brwhite)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color cyan)(prompt_pwd)(set_color brwhite)' '(set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯'(set_color brwhite)' '
end
