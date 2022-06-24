# Windows 10 Setup

## 1. Open the following Links and Run through each installer
When prompted by installer wizards, please use all defaults.

* [*Google Chrome*](https://www.google.com/chrome/)
* [*VS Code*](https://code.visualstudio.com/)


## 2. Install Git for Windows

https://gitforwindows.org/


**WSL Option**
https://www.youtube.com/watch?v=sUsTQTJFmjs

Alternatively, Windows 10 and Greater has support for Windows Subsystem Linux (WSL). I attempted to install on Virtual Box Win 11, and there were a lot of hoops to jump through. If you do go this route, you must work out any issues you encounter.

## 3. Install Node
* [*Node/NPM Installer*](https://nodejs.org/en/download/)
  * Install Defaults

## 4. Install VS Code Extensions
run the following command in your new Git For Windows Terminal.
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-extensions.sh)"
```

## 5. Manually Install Settings
We will manually add these to your windows system together.

* [Download VS Code snippets.zip](https://raw.githubusercontent.com/meatch/system-setup/master/snippets.zip?raw=true)
    * Windows Stores Snippets Here: `%APPDATA%\Code\User\snippets\`
* [VS Code settings.json](https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-settings.json)
    * Windows Stores Snippets Here: `%APPDATA%\Code\User\`


## 6. Download the Web Starter Project

1. Run the following in Bash Terminal `git clone https://github.com/meatch/Web-Starter-Project.git`
2. Rename Folder to `Web1-Last-First-Final`. Replacing your First and Last Name accordingly
3. Remove `.git` folder in root of Starter Project Folder