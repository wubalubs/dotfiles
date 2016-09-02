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

alias ls='ls -l --color=auto --block-size=M'

export EDITOR=nano

#### ALIAS PARTY ####
alias bshupd='. ~/.bashrc'
alias zshupd='. ~/.zshrc'
alias cls='clear'

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
alias pacdet='sudo pacman -Qie'

alias boop='sudo nmap -Pn'
alias pulse=''
 
alias gitstat='/usr/local/bin/gitstat.sh'



#### FUNCTION JUNCTION ####
function weather() {
	local URL=http://wttr.in/$1
	curl -s $URL
}


function dotsync() {
	local ZSHRC="$HOME/.zshrc"
if [ -e "$ZSHRC" ];
	then 
		echo "Copying zsh files..."
		printf "\n"
		cp -v $ZSHRC $HOME/Projects/git/dotfiles/zsh/.zshrc
		printf "\n"
		git --git-dir=$HOME/Projects/git/dotfiles/.git --work-tree=$HOME/Projects/git/dotfiles status	
		
		printf "\n"
		printf "Push to git?\n"
		read answer
	
		case $answer in 
			y)
				printf "Pushing to git...\n"
				sleep 1
				git --git-dir=$HOME/Projects/git/dotfiles/.git --work-tree=$HOME/Projects/git/dotfiles add .
				git --git-dir=$HOME/Projects/git/dotfiles/.git --work-tree=$HOME/Projects/git/dotfiles commit -m "zshrc updates" -v
				git --git-dir=$HOME/Projects/git/dotfiles/.git --work-tree=$HOME/Projects/git/dotfiles push origin master -v
				;;
			n)
				printf "Skipping git push and exiting....\n";;
		esac
else 
		echo "$ZSHRC not found!!"
fi 

 	}


function atty() {
	sudo docker exec -it $1 /bin/ash
}
function btty() {
	sudo docker exec -it $1 /bin/bash
}

function tfmod {
	printf "\033[35mThe lines below have been modified\033[0m\n"
	cat $3 | grep $1
	sed -i -e s/$1/$2/g $3
	printf "\033[35m\nChanges are highlighted below:\033[0m\n"	
	cat $3 | grep $2
}

function netinfo() {
	PUBLIC=$(curl -s -4 icanhazip.com)
	pushd /sys/class/net > /dev/null
	INTERFACES=(*)
	popd > /dev/null

	for i in "${INTERFACES[@]}";

	do
		if [[ $i != docker* && $i != lo* && $i != eth* && $i != en* ]] ; 
		then
			iwconfig $i
		fi
	done
	ip -4 addr | grep inet
	printf "\nCurrent public is $PUBLIC\n"
}

