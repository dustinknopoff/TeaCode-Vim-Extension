# TeaCode Vim Helper

Provides integration with TeaCode https://www.apptorium.com/teacode

TeaCode is a powerful app, created to write code super fast by expanding short, dynamic code templates into the real code. It comes with a simple variable-based language that supports subexpressions, optional patterns and filters. Creating new expanders is extremely easy. TeaCode supports native editors (Xcode, TextMate, Coda, etc.) as well as Atom, Sublime Text, VSC and JetBrains IDEs (PHPStorm, AppCode, etc.) and now Vim.

![](./example.gif)

## How to install

Assuming you are using [Vundle](https://github.com/gmarik/Vundle.vim). Adapt for your plugin manager of choice. Add this to your `.vimrc`

```vim
Plugin 'dustinknopoff/TeaCode-Vim-Extension'

imap <C-e> <C-O>:call TeaCodeExpand()<CR>
```

**Requires Python**

**NOTE** you must have [TeaCode](https://www.apptorium.com/teacode) installed.

## How to use it

1. Install TeaCode from https://www.apptorium.com/teacode.
2. Open TeaCode
3. Write an expression (for example `-f helloWorld`) and press ctrl+alt+e (notice that shortcut is different than the shortcut for native macOS apps)

## Backlog

See our to-do list here on Github be checking out this [link](https://github.com/dustinknopoff/TeaCode-Vim-Extension/labels/to-do). https://github.com/dustinknopoff/TeaCode-Vim-Extension/labels/to-do
