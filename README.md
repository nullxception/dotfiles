<p align="center">
  <img src="https://user-images.githubusercontent.com/58150791/71537208-ffe23900-295b-11ea-841b-318adfe977d8.png" />
</p>
<p align="center">
nullxception's desktop and other configurations
</p>
<p align="center">
  <a href="LICENSE" target="_blank">
    <img alt="License: BSD 3--Clause License" src="https://img.shields.io/badge/License-BSD 3--Clause License-yellow.svg" />
  </a>
  <a href="https://twitter.com/nullxception" target="_blank">
    <img alt="Twitter: nullxception" src="https://img.shields.io/twitter/follow/nullxception.svg?style=social" />
  </a>
</p>

## What the heck is this 🤔

It just a dotfiles repo, which is a set of some configurations that commonly used by me on my desktop and server.

It was supposed to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup.
So, don't be shy, give a ⭐️ if some configs can helps you :)

## 🏗 Installation

After cloning the repo, you can run this command :

```
./install.sh <topic-name>
```
and that's pretty much it 😊

## 📑 Topic Structures
As you can see, this dotfiles is grouped by topics.

Each of it has their own `.module-data.bash` files that will be used by `install.sh`. Here's some methods that currently supported by the `install.sh`.

* **basic copy-to-target**

    For simple structures like the `audio` topic, `install.sh` will deploy all the files inside `audio` topic into `$HOME/.config/`, which's already defined in `audio/.module-data.bash` by `module_target` variable.

* **custom install method**

    For another topics that needs dynamic operation like `firefox`, `install.sh` will using `module_install()` function that already defined in `firefox/.module-data.bash`.

* **dynamic destination**

    Since `.module-data.bash` are just merely a bash script that will be evaluated by `install.sh`, we can also utilize the power of shell script to extends it.
    For example, `vscode` topic has a simple prompt to choose the install destination.

* or, **No install method at all.**

    There's an another topic that has no `.module-data.bash` file, the `script` topic.

    Unlike `bin`, this topic are only meant to store executable scripts, portably, no need to be installed on anywhere.

## 💬 FAQ

🤔: _Can I use it on my machine ?_

For some topic like `shell` or `firefox`, yes.

But for `etc` topic, I don't think you want to install it blatantly, since it's a system configuration, tho you can still use it as a references (maybe ?) :)

🤔: _Why don't use ansible/stow/yadm/etc instead ?_

All of my systems is using GNU/Linux, so I think simple bash script already enough for my cases.

🤔: _Is there any LDA or r/unixporn-able desktop suite configuration here ?_

I'm just your regular desktop-environment neighbor (ATM) :)

## 📄 License

Copyright © 2019 [Nauval Rizky](https://github.com/nullxception). This project is [BSD 3-Clause License](LICENSE) licensed.
