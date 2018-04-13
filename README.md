# What is this

A plugin which could help you quickly jump to specific file with completion.

# How to use

Just set variable like following:

```vim
" this is the default setting
let g:file_jumper_command = {
            \ "Gbin": {'dir': expand("$HOME/bin"), 'extension': ''},
            \ "Gwiki": {'dir': g:myvimwikidir, 'extension': '.wiki', 'keymap': '<Leader>wg'},
            \ }
```

* `dir` specifiy which directory should the command look file for
* `extension` will automatically appended to the filename
* `keymap` will define keymap for the command

Then command `Gbin` and `Gwiki` will be defined. Now you can jump to file `~/bin/pyserver` with command
`Gbin pyserver`. Moreover, the file name could be completed if you press `tab` key:

<img src="http://on2hdrotz.bkt.clouddn.com/blog/1523648508011.png" width="562"/>

## Quick open file with specific command

Any vim command could be appended to open file in different window.
For example, execute `Gbin pyserver vnew` is same with `vnew ~/bin/pyserver`.
Other command like `bot vnew` could also be used.
