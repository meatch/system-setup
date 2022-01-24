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
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
echo "VS Code: Install Plugins"
code --install-extension aaron-bond.better-comments
code --install-extension alefragnani.Bookmarks
code --install-extension ban.spellright
code --install-extension bradgashler.htmltagwrap
code --install-extension calebporzio.better-phpunit
code --install-extension christian-kohler.path-intellisense
code --install-extension cjhowe7.laravel-blade
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension demijollamaxime.bulma
code --install-extension diigu.copywithline
code --install-extension donjayamanne.githistory
code --install-extension DotJoshJohnson.xml
code --install-extension eamodio.gitlens
code --install-extension ecodes.vscode-phpmd
code --install-extension EQuimper.react-native-react-redux
code --install-extension esbenp.prettier-vscode
code --install-extension felixfbecker.php-debug
code --install-extension felixfbecker.php-intellisense
code --install-extension felixfbecker.php-pack
code --install-extension gencer.html-slim-scss-css-class-completion
code --install-extension GrapeCity.gc-excelviewer
code --install-extension Gruntfuggly.todo-tree
code --install-extension HookyQR.JSDocTagComplete
code --install-extension huizhou.githd
code --install-extension humao.rest-client
code --install-extension joelday.docthis
code --install-extension jpoissonnier.vscode-styled-components
code --install-extension kokororin.vscode-phpfmt
code --install-extension kruemelkatze.vscode-dashboard
code --install-extension lamartire.git-indicators
code --install-extension michelemelluso.code-beautifier
code --install-extension mikestead.dotenv
code --install-extension mrmlnc.vscode-scss
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-mssql.mssql
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode.Theme-MarkdownKit
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension neilbrayfield.php-docblocker
code --install-extension oderwat.indent-rainbow
code --install-extension onecentlin.laravel-blade
code --install-extension sadesyllas.vscode-workspace-switcher
code --install-extension Shan.code-settings-sync
code --install-extension SirTori.indenticator
code --install-extension sleistner.vscode-fileutils
code --install-extension techer.open-in-browser
code --install-extension teclado.vscode-nginx-format
code --install-extension TimonVS.ReactSnippetsStandard
code --install-extension tomoki1207.pdf
code --install-extension vscode-icons-team.vscode-icons
code --install-extension waderyan.gitblame
code --install-extension wayou.vscode-todo-highlight
code --install-extension william-voyek.vscode-nginx
code --install-extension xabikos.JavaScriptSnippets
code --install-extension yassh.copy-with-line-numbers
code --install-extension yzane.markdown-pdf
code --install-extension yzhang.markdown-all-in-one
code --install-extension ziyasal.vscode-open-in-github

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

echo "Web Starter Project: Git clone app to desktop"
git clone https://github.com/meatch/Web-Starter-Project.git ~/Desktop/Web1-Lastname-First-Final

echo "Web Starter Project: remove .git versioning from project"
rm -rf ~/Desktop/Web1-Lastname-First-Final/.git

echo "Web Starter Project: Open Desktop in Finder"
code ~/Desktop/Web1-Lastname-First-Final