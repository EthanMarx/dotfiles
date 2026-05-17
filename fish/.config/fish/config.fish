starship init fish | source

function fish_user_key_bindings
    bind \cy accept-autosuggestion
	bind \cp history-search-backward
	bind \cn history-search-forward
end

fish_add_path ~/.local/bin/


set -x EDITOR nvim
alias vim="nvim"
alias vi="nvim"


