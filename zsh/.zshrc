# Path to your oh-my-zsh installation.
  export ZSH=/home/david/.oh-my-zsh

# Set name of the theme to load. Zsh looks in ~/.oh-my-zsh/themes
ZSH_THEME="amuse"

# Load plugins to zsh Ex: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'


#### ALIAS PARTY ####
alias bshupd='. ~/.bashrc'
alias zshupd='. ~/.zshrc'

alias reboot='sudo reboot'
alias systemctl='sudo systemctl'
alias ps='sudo ps'
alias updatedb='sudo updatedb'
alias docker='sudo docker'

alias pacupg='sudo pacman -Syu'
alias pacsrc='sudo pacman -S'
alias pacfnd='sudo pacman -Ss'
alias pacupd='sudo pacman -Sy'
alias pacrmv='sudo pacman -R'

alias boop='sudo nmap -sS'
alias pulse=''





#### FUNCTION JUNCTION ####
function dotsync() {
	local ZSHRC="$HOME/.zshrc"
if [ -e "$ZSHRC" ];
	then 
		echo "Copying zsh files..."
		printf "\n"
		cp -v $ZSHRC $HOME/Projects/git/dotfiles/zsh/.zshrc
		printf "\n"
		git --git-dir=$HOME/Projects/git/dotfiles/.git --work-tree=$HOME/Projects/git/dotfiles status	
else 
		echo "$ZSHRC not found!!"
fi 

}


function dtty() {
	sudo docker exec -it $1 /bin/ash
}

function tfmod {
	printf "\033[35mThe lines below have been modified\033[0m\n"
	cat $3 | grep $1
	sed -i -e s/$1/$2/g $3
	printf "\033[35m\nChanges are highlighted below:\033[0m\n"	
	cat $3 | grep $2
}
