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

## textlint

```shell
npm -g install  textlint-rule-no-mix-dearu-desumasu textlint-rule-no-doubled-joshi textlint-rule-no-double-negative-ja textlint-rule-no-hankaku-kana textlint-rule-no-mixed-zenkaku-and-hankaku-alphabet textlint-rule-ja-no-redundant-expression textlint-rule-no-dropping-the-ra textlint-rule-no-doubled-conjunctive-particle-ga textlint-rule-no-doubled-conjunction textlint-rule-prefer-tari-tari @textlint-ja/textlint-rule-no-synonyms textlint-rule-ja-no-orthographic-variants textlint-rule-ja-space-between-half-and-full-width textlint-rule-sentence-length
```
