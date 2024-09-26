# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#force load the autocompletition info if present
if compgen -G "/etc/bash_completion.d/*.sh" > /dev/null; then
    # If files are found, source each of them
    for file in /etc/bash_completion.d/*.sh; do
        source "$file"
    done
fi

#color
#PS1='\[\e[1;32m\]\u\[\e[0m\]@\[\e[1;32m\]\h:\[\e[1;34m\]\w\[\e[0m\]\$ '


#up autocomplete Suse like 
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
#godies
#alias ll='ls -alF'

