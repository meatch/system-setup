# Windows 10 Setup

<img height="100"  src="./img/windows.png">

## 1. Open the following Links and Run through each installer
When prompted by installer wizards, please use all defaults.

* [*Google Chrome*](https://www.google.com/chrome/)
* [*VS Code*](https://code.visualstudio.com/)



## 2. Install Bash, Zsh, Git and Oh My Zsh

https://www.maketecheasier.com/install-zsh-and-oh-my-zsh-windows10/



## 3. Install Node, NPM and Yarn
* [*Node/NPM Installer*](https://nodejs.org/en/download/)
  * Install Defaults
* [*Yarn Download Installer*](https://classic.yarnpkg.com/en/docs/install/#windows-stable)



-- OLDER ...

* Install [*Git for Windows*](https://git-scm.com/download/win)
  * Choose all defaults
  * If we run into issues, we may need to [manually connect integrated terminal to Git Bash](https://stackoverflow.com/questions/42606837/how-do-i-use-bash-on-windows-from-the-visual-studio-code-integrated-terminal)


Note: if bash does not work, we will need to install it.
[Windows Bash](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## 2. Open UCLAX-Course-Folder in VS Code

1. Open VS Code
2. File -> Open Folder
3. Choose the `UCLAX-Course-Folder`
4. Press Open

## 3. Run VS Code and Course Projects Setup script

1. In root of Project Folder; Rename `config.example.js` to `config.js`
2. Open `config.js` and change first and last name to your first and last name (e.g. name: "Mitch Gohman")
3. Control + Shift + P:
   1. Type: Terminal: Select Default Profile
   2. Choose Git Bash
4. Within VS Code Open Terminal
5. Terminal -> New Terminal
6. Pre-Flight Check: Test that we installed everything correctly
   1. `git --version` : >= 2.32.0
   2. `bash --version` : >= Windows any bash will do
   3. `node -v` : >= 14.7.1
   4. `yarn -v` : >= 1.22.5
7. type the following command: `yarn install && yarn winSetup` and press return
8. Paste the following command to install extensions

```
curl -fsSL https://gist.githubusercontent.com/meatch/fe7bc147cf31a2c20ba0c92771942174/raw/f189bd2af9475c3944d2ba41d211fe7e6c9a597c/gistfile1.txt
```

