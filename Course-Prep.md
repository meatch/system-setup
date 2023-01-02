# Course Prep

Do the following each term to prep this repo for class

1. Head over to the VS Code User Folder

    ```bash
    open ~/Library/Application\ Support/Code/User/
    ```

2. Copy contents of `User/settings.json` into `vs-code-settings.json`

3. Update snippets.zip

   1. Compress snippets folder and its contents
   2. replace `snippets.zip` in root of repo <------

4. Update VS Code Extensions

   1. List Installed Extensions

      ```bash
      code --list-extensions | xargs -L 1 echo code --install-extension
      ```

   2. Update `vs-code-extensions.sh` <----
