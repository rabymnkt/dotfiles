# dotfiles

I use [chezmoi](https://github.com/twpayne/chezmoi).

## How to use

### 1. Install chezmoi

Follow [official documents](https://www.chezmoi.io/install/)

For ubuntu,
```shell
$ sh -c "$(curl -fsLS get.chezmoi.io)"
```

For macOS (homebrew)
```shell
$ brew install chezmoi
```

### 2. Fetch dotfiles
```shell
$ chezmoi init https://github.com/rabymnkt/dotfiles.git
```

### 3. Check differences between local dotfiles and remote dotfiles in repo
```shell
$ chezmoi diff
```

### 4. Apply changes
```shell
$ chezmoi -v apply
```
If you use `-n` option, you can apply changes in dry-run mode.
