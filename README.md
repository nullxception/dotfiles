# nullxception's dotfiles

This repo contains set of some configurations that commonly used by me on my desktop and server.

It was supposed to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup. So, don't be shy, give a ⭐️ if some configs can helps you :)

# bit of showcase
![swaywm in floating mode](https://user-images.githubusercontent.com/58150791/176631500-24c6f691-33a7-438a-a1a4-c68686680c54.png)
> swaywm in floating mode, wallpaper source: https://www.pixiv.net/en/artworks/97134787

![cherry rofi theme](https://user-images.githubusercontent.com/58150791/176835430-925d2b83-443d-4090-9b20-d56f5c1fb133.png)
> [cherry rofi theme](rofi/theme/cherry.rasi) in various modes

# Installation

Since this dotfiles is grouped by topic, you can just run the install script followed by the topic name (or path, to be precise).

```bash
./install.sh <topic>
```

> for example, installing sway and waybar config
```bash
./install.sh sway
./install.sh waybar
```

# Structures

As you can see, the configs is grouped by topic.

Each of it has their own `.install` script that will be used by the [`install.sh`](install.sh).

For complete example, take a look at [`.install.example`](.install.example).

# Frequently Asked Question

> Can I use this on my machine ?

Yup, especially for some topic like [`nvim`](nvim) or [`kitty`](kitty).

But for things like [`etc`](etc) or [`hw`](hw), I suggest you to NOT INSTALL it blatantly since it is a system configuration.

> Why don't use ansible/stow/yadm/etc instead ?

For simple task such deploying dotfiles, shell script is more than enough for me.

## License

This work is licensed under [BSD 3-Clause License](LICENSE).
