# Windows 10 Setup

## 1. Open the following Links and Run through each installer
When prompted by installer wizards, please use all defaults.

* [*Google Chrome*](https://www.google.com/chrome/)
* [*VS Code*](https://code.visualstudio.com/)


## 2. Install Bash, Zsh, Git and Oh My Zsh
### Turning on bash
1. Open Settings and click on “Updates & Security.”
2. Click “For developers” in the sidebar, then click the radio button next to “Developer mode.”
3. In the pop-up window, click “Yes” to proceed with enabling developer mode.
4. Open Control Panel and navigate to the “Programs and Features” menu.
5. Click “Turn Windows features on or off” in the sidebar.
6. Scroll down and tick the checkbox next to “Windows Subsystem for Linux (Beta)” to enable the Linux subsystem. Then click the “OK” button.
7. Wait for the installer to finish.
8. When the installer is finished, click “Restart Now” to restart your computer and complete the installation.
9. After you’ve restarted your computer, type “bash” into the Start Menu and launch the bash script.
10. This will open a command prompt and finish installing UNIX and Bash. Type the “y” key and press “Enter” to confirm installation of the remaining components.
11. Wait while the remaining components are downloaded and configured.
12. When prompted, create a username for Bash and UNIX. single word usernname (e.g. coolio)
13. Enter a password you’ll use for Bash and UNIX. You won’t see any characters appear as you type, but they are being saved. Press “Enter.”
14. When the installation is finished, you’ll be returned to the command prompt. You can now close this window.

### Installing zsh
1. Open Bash from the Start Menu.
2. Type the following command into the command prompt and press “Enter:”
```
sudo apt-get install zsh
```
3. Enter your Bash/UNIX password when prompted and press “Enter.”
4. When prompted, type “Y” and press “Enter” to continue the installation.
5. When the installation is complete, you’ll be returned to the command prompt.

### Using zsh
1. Open Bash from the Start Menu.
2. Type zsh and press “Enter.”
3. On first run, you’ll need to go through some zsh configuration options. Choose the “2” key to accept the default configuration.
4. When the configuration is complete, you’ll be returned to the zsh command prompt.

### Installing Git and Oh My Zsh
1. Open Bash from the Start Menu.
2. Use the following command to download and install git, a prerequisite for installing Oh My Zsh:
```
sudo apt-get install git
```
3. Once git is installed, we can download and install Oh My Zsh. To do so, copy and paste the following command into your command line and press “Enter.”
```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
4. Enter your Bash/UNIX password when prompted and press “Enter.”
5. When the installation is finished, you’ll see Oh My Zsh’s ASCII art.

> Original Instructions
> https://www.maketecheasier.com/install-zsh-and-oh-my-zsh-windows10/

## 3. Install Node, NPM and Yarn
* [*Node/NPM Installer*](https://nodejs.org/en/download/)
  * Install Defaults
* [*Yarn Download Installer*](https://classic.yarnpkg.com/en/docs/install/#windows-stable)

## 4. Install VS Code Extensions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-extensions.sh)"

## 4. Manually Install Settings
We will manually add these to your windows system together.

[Download VS Code snippets.zip](https://raw.githubusercontent.com/meatch/system-setup/master/snippets.zip?raw=true)
[VS Code settings.json](https://raw.githubusercontent.com/meatch/system-setup/master/vs-code-settings.json)