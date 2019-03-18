function dot
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end

function dotls
	dot ls-tree -r master --name-only $argv
end
