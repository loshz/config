PROMPT='%B%{$fg[green]%}[%n@%m] %c $%{$reset_color%}%b '
return_code="%B%(?..%{$fg[red]%}%? %{$reset_color%})%b"
RPROMPT='${return_code}[%*]%{$reset_color%}'
