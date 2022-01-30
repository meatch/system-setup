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

echo "MacOS: Pre-Setup: Installing MacOS Terminal And App Management Software"

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
# Capture User Details in bash prompt 
###################
read -p "Enter your First Name: " userfirstname
ufname=$(toTitleCase $userfirstname)

read -p "Enter your Last Name: " userlastname
ulname=$(toTitleCase $userlastname)

read -p "Enter your Email: " useremail
uemail=$(toLowerCase $useremail)

echo "User Details: Name: $ufname $ulname, Email: $uemail"


###################
# Homebrew 
###################
echo "Install or Update Homebrew"
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
if [ -d ~/.oh-my-zsh ]; then
    echo "Oh-My-Zsh Already installed"
else
    echo "Install Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

###################
# Update .zshrc with app specific tools
###################
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
if [[ -f $HOME/.nvm/nvm.sh ]] ; then
    echo "NVM already Installed"
else
    echo "Install NVM"
    brew install nvm
fi

# Manual Sourcing of NVM Support
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

echo "NVM: Install Node Version 14"
nvm install 14

echo "NVM: Make Node Version 14 the default"
nvm alias default 14

echo "brew: Install Yarn"
brew install yarn

# Google Chrome
if [ -d "/Applications/Google Chrome.app" ]; then
    echo "Google Chrome Already installed"
else
    echo "Install Google Chrome"
    brew install google-chrome
fi

# VS Code
if [ -d "/Applications/Visual Studio Code.app" ]; then
    echo "Visual Studio Code Already installed"
else
    echo "Install Visual Studio Code"
    brew install visual-studio-code
fi

# VS Code Settings
curl -sS https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-settings.json > "$HOME/Library/Application Support/Code/User/settings.json"

# VS Code Plugins
echo "VS Code: Install Extensions: https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-extensions.sh"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-extensions.sh)"

# VS Code Snippets
if [ -f "$HOME/Library/Application Support/Code/User/snippets/c1.code-snippets" ]; then
    echo "VS Code: Snippets Already Installed"
else
    echo "VS Code: Add Snippets"

    mkdir "$HOME/Library/Application Support/Code/User/snippets"
    curl -sS https://raw.githubusercontent.com/meatch/system-setup/master/snippets.zip?raw=true > "$HOME/Library/Application Support/Code/User/snippets/temp.zip"
    unzip "$HOME/Library/Application Support/Code/User/snippets/temp.zip" -d "$HOME/Library/Application Support/Code/User/snippets"
    rm "$HOME/Library/Application Support/Code/User/snippets/temp.zip"
fi

###################
# Update Git Author and Email
###################

# Update Git Author Full Name
git config --global user.name "$ufname $ulname"

# Update Git Author Email
git config --global user.email "$uemail"


###################
# Web Starter Project
###################
finalFolder="$HOME/Desktop/Web1-$ulname-$ufname-Final"

echo "Your Final Folder: $finalFolder"

echo "Web Starter Project: Git clone app to desktop"
git clone https://github.com/meatch/Web-Starter-Project.git $finalFolder

echo "Web Starter Project: remove .git versioning from project"
rm -rf "$finalFolder/.git"

echo "Web Starter Project: Open $finalFolder in Finder"
open $finalFolder