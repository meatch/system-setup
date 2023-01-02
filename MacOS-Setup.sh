#!/bin/bash

# We don't need return codes for "$(command)", only stdout is needed.
# Allow `[[ -n "$(command)" ]]`, `func "$(command)"`, pipes, etc.
# shellcheck disable=SC2312

# set -u

abort() {
    printf "%s\n" "$@"
    exit 1
}

# Fail fast with a concise message when not using bash
# Single brackets are needed here for POSIX compatibility
# shellcheck disable=SC2292
if [ -z "${BASH_VERSION:-}" ]
then
    abort "Bash is required to interpret this script."
fi

###################
# Init
###################

echo "MacOS Web Essentials: Start"

function wordUpperCaseFirst {
    echo $(tr '[:lower:]' '[:upper:]' <<< ${1:0:1})${1:1}
}

function toLowerCase {
    tr [:upper:] [:lower:] <<< "${*}"
}

function toTitleCase {
    lowercase=$(toLowerCase $1)
    title=$(wordUpperCaseFirst $lowercase)
    echo $title
}

###################
# Working Directory
###################
echo "MacOS Web Essentials: Switch to Desktop working directory."

cd ~/Desktop

###################
# Capture User Details in bash prompt
###################
echo "MacOS Web Essentials: User specific settings"

courseName="Uclax-Web1"

read -p "Enter your First Name: " userfirstname
ufname=$(toTitleCase $userfirstname)

read -p "Enter your Last Name: " userlastname
ulname=$(toTitleCase $userlastname)

read -p "Enter your Email: " useremail
uemail=$(toLowerCase $useremail)

echo "User Details: Name: $ufname $ulname, Email: $uemail attending $courseName"

###################
# Homebrew
###################
echo "MacOS Web Essentials: Install or Update Homebrew"

which -s brew
if [[ $? != 0 ]] ; then
    echo "Install Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Update Homebrew"
    brew update
fi

###################
# Zsh
###################
echo "MacOS Web Essentials: Install Zsh"

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    echo "ZSH is already installed."
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    echo "BASH is default, must be older OS - installing ZSH."
    brew install zsh
    chsh -s /usr/local/bin/zsh
else
    echo "Odd, neither ZSH or BASH is installed, attempting to install ZSH"
    brew install zsh
    chsh -s /usr/local/bin/zsh
fi

###################
# Oh My Zsh
###################
echo "MacOS Web Essentials: Install Oh-My-Zsh"

if [ -d ~/.oh-my-zsh ]; then
    echo "Oh-My-Zsh Already installed"
else
    echo "Install Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

###################
# Update .zshrc with app specific tools
###################
echo "MacOS Web Essentials: Configuring Bash Profiles"

# NVM Support
if grep -q NVM_DIR ~/.zshrc; then
    echo "Update .zshrc: Already Exists: NVM Support"
else
    echo "Update .zshrc: Add NVM Support"
    echo -e "# NVM Support\nexport NVM_DIR=\"\$HOME/.nvm\"\nsource \$(brew --prefix nvm)/nvm.sh\n\n$(cat ~/.zshrc)" > ~/.zshrc
fi

# VS Code Support and Homebrew Support
if grep -q "Applications/Visual" ~/.zshrc; then
    echo "Update .zshrc: Already Exists: VS Code shell code command"
else
    echo "Update .zshrc: Add VS Code shell code command and Homebrew Path"
    echo -e "# VS Code code command\nexport PATH=\"\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/opt/homebrew/bin\"\n\n$(cat ~/.zshrc)" > ~/.zshrc
fi

# Manual sourcing of VS Code code command
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/opt/homebrew/bin"

###################
# Install the rest of the Apps we need.
###################
echo "MacOS Web Essentials: Visual Studio Code (VS Code)"
if [ -d "/Applications/Visual Studio Code.app" ]; then
    echo "Visual Studio Code Already installed"
else
    echo "Install Visual Studio Code"
    brew install visual-studio-code
fi

echo "MacOS Web Essentials: Visual Studio Code (VS Code): Open to ensure user settings have been initialized (if never opened before)."
open -a /Applications/Visual\ Studio\ Code.app

echo "MacOS Web Essentials: Install Node Version Manager (NVM)"

if [[ -f $HOME/.nvm/nvm.sh ]] ; then
    echo "NVM already Installed"
else
    echo "Install NVM"
    brew install nvm
fi

# Manual Sourcing of NVM Support
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

echo "NVM: Install Node Version 18"
nvm install 18.12.1

echo "NVM: Make Node Version 18 the default"
nvm alias default 18.12.1

# Google Chrome
echo "MacOS Web Essentials: Install Google Chrome"

if [ -d "/Applications/Google Chrome.app" ]; then
    echo "Google Chrome Already installed"
else
    echo "Install Google Chrome"
    brew install google-chrome
fi



###################
# Update Git Settings
###################

echo "MacOS Web Essentials: Git: Update Author Name and Email"
git config --global user.name "$ufname $ulname"
git config --global user.email "$uemail"

echo "MacOS Web Essentials: Git: Use VS Code as Git Editor"
git config --global core.editor "code --wait"

echo "MacOS Web Essentials: Git: Set git default branch back to the original \"master\" branch. In case they tried to change it to main; which is silly."
git config --global init.defaultbranch "master"


###################
# Web Starter Project
###################
echo "MacOS Web Essentials: Course Project Folder"
projectFolder="$courseName-$ulname-$ufname"
echo "MacOS Web Essentials: Course Project Folder: Name: $projectFolder"

echo "MacOS Web Essentials: Course Project Folder: Vite React Install"
npm create vite@latest $projectFolder -- --template react

echo "MacOS Web Essentials: Course Project Folder: Open $projectFolder in VS Code"
code $projectFolder

# VS Code Settings
echo "MacOS Web Essentials: VS Code: Settings"
curl -sS https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-settings.json > "$HOME/Library/Application Support/Code/User/settings.json"

# VS Code Plugins
echo "MacOS Web Essentials: VS Code: Plugins"
echo "VS Code: Install Extensions: https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-extensions.sh"
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-extensions.sh)"

# VS Code Snippets
echo "MacOS Web Essentials: VS Code: Snippets"
if [ -f "$HOME/Library/Application Support/Code/User/snippets/c1.code-snippets" ]; then
    echo "VS Code: Snippets Already Installed"
else
    echo "VS Code: Add Snippets"

    mkdir "$HOME/Library/Application Support/Code/User/snippets"
    curl -sS https://raw.githubusercontent.com/meatch/system-setup/master/snippets.zip?raw=true > "$HOME/Library/Application Support/Code/User/snippets/temp.zip"
    unzip "$HOME/Library/Application Support/Code/User/snippets/temp.zip" -d "$HOME/Library/Application Support/Code/User/snippets"
    rm "$HOME/Library/Application Support/Code/User/snippets/temp.zip"
fi

# Open VS Code User in Finder to check settings and snippets
echo "MacOS Web Essentials: VS Code: Open Finder VS Code User Folder to review settings and snippets"
open ~/Library/Application\ Support/Code/User/

