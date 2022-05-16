set fish_greeting

# aliases
alias vim="nvim"

status --is-interactive; and rbenv init - fish | source

switch (uname)
	case Darwin
		source (dirname (status --current-filename))/config-darwin.fish
	case Linux
		source (dirname (status --current-filename))/config-linux.fish
end

# init starship
starship init fish | source
