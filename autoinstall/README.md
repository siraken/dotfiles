# Auto Install

## macOS

[Install Homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```
brew tap Homebrew/bundle
brew bundle
```

## Windows

Run the command below on Terminal as administrator.
Packages that can be installed should be found on the [winget](https://winget.org/) website.

```powershell
winget import [filename.json]
```

To export the packages to a json file, run the command below on Terminal.

```powershell
winget export [filename.json]
```

## Linux

### Ubuntu
