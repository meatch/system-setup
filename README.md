# System Setup
This repo is used to help set up the latest tools for Web Development

## MacOS Set Up

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/meatch/system-setup/master/MacOS-Setup.sh)"
```

### Troubleshooting

If you run into issues installing Brew, most likely `XCode Command Line Tools` have yet to be installed.

Try the following, and after installing `XCode Command Line Tools` try the brew MacOs setup installation again.

```
xcode-select --install
```


## Windows Setup

[Follow these Windows Setup Instructions](Windows-Setup.md)
