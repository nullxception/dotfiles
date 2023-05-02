# nullxception's dotfiles

This repo contains set of some configurations that commonly used by me on my desktop and server.

It was supposed to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup. So, don't be shy, give a ⭐️ if some configs can helps you :)

# Installation

Since this dotfiles is grouped by topic, you can just run the install script followed by the topic name (or path, to be precise).

```bash
./install.sh <topic>
```

> for example, installing kitty and nvim config
```bash
./install.sh kitty nvim
```

# Structures

As you can see, the configs is grouped by topic.

Each of it has their own `.install` script that will be used by the [`install.sh`](install.sh).

For complete example, take a look at [`.install.example`](.install.example).

# Frequently Asked Question

> Can I use this on my machine ?

Yup, especially for some topic like [`nvim`](nvim) or [`kitty`](kitty).

But for things like [`sys/hw`](sys/hw) or [`sys/systemd`](sys/systemd), I suggest you to NOT INSTALL it blatantly since it is a system-wide configuration.

> Why don't use ansible/stow/yadm/etc instead ?

For simple task such deploying dotfiles, shell script is more than enough for me.

## License

This work is licensed under [BSD 3-Clause License](LICENSE).
