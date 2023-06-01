![firefox preview](../.github/assets/firefox.webp)

> Firefox w/ custom css and [Cherry Midnight](https://addons.mozilla.org/en-US/firefox/addon/cherry-midnight) theme

# Firefox setup

You can copy the necessary files into your own firefox profile directory. Or use the install script to set it up automatically, like this :

```bash
# from root of the dotfiles directory
./dot.sh firefox
./bin/firefoxutil --link-dots

```

Those command will install the files into `~/.mozilla/firefox/dots` dir, and then link any files inside the `dots` dir into available profiles.

## Change about:newtab background

My custom [userContent CSS](userContent.css) allows for custom background image.

To set it, you can just copy your favorite picture into your chrome directory, or you can also use the [firefoxutil](../bin/firefoxutil) to do that:

```bash
./bin/firefoxutil --set-newtab-bg ~/Pictures/wallpaper/pixiv-id-98617008-1080.jpg
```
