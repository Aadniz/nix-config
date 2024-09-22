# *Shhhhhhhhhhhhh*

When changing `.bin` files, decrypt them into `.raw.bin`, and then encrypt them back again to `.bin`.
`.raw.bin` is ignored in `.gitignore`

``` shell
$ sops -d thing.bin > thing.raw.bin
$ nano|vim|emacs thing.raw.bin
$ sops -e thing.raw.bin > thing.bin
```
