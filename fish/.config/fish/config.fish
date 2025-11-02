starship init fish | source

function fish_user_key_bindings
    bind \cy accept-autosuggestion
	bind \cp history-search-backward
	bind \cn history-search-forward
end


 



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/ethanmarx/opt/miniconda3/bin/conda
    eval /Users/ethanmarx/opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/ethanmarx/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/ethanmarx/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/ethanmarx/opt/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

