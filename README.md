## Dotfiles

My dotfiles - use them and contribute your personal changes/suggestions.

### Installation (export)

Copy all files over the current existing ones (this will effectivly overwrite
any current settings).

```
make export
```

### Publish settings (import)

Copies a list of files into the current workspace, ready for committing.

```
make import
```

### Contribution

Pull requests are welcome, but please state with comments what the settings are
actually doing, unless the setting are somehow self explaining.

e.g. in the `.vimrc` file, it's definitely NOT required to state explicitly, what
`syntax enable` is doing, however would you know what those settings are doing
without the explanation in the comments?

```
"Supress warning when changing FROM unsaved buffer
set hidden

"Demand explicit confirmation when closing unsaved buffers
set confirm
```
