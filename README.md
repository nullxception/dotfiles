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

* Linux

  ```bash
  ./install.sh <topic>
  ```

* Windows (from pwsh)

  ```powershell
  .\install.ps1 <topic>
  ```

and that's pretty much it 😊

## 📑 Structures
As you can see, this dotfiles is grouped by topic.

Each of it has their own `.install` (`.install.ps1` if the topic is usable on Windows) script that will be used by the [`.install.sh`](.install.sh)

For complete example, take a look at [`.install.example`](.install.example) and [`.install.ps1.example`](.install.ps1.example).

## 💬 FAQ

🤔: _Can I use it on my machine ?_

For some topic like `audio` or `firefox`, yes.

But for `etc` topic, I don't think you want to install it blatantly, since it's a system configuration, tho you can still use it as a references (maybe ?) :)

🤔: _Why don't use ansible/stow/yadm/etc instead ?_

For simple task such installing dotfiles, I think shell script is more than enough for me.

## 📄 License

Copyright © 2019 [Nauval Rizky](https://github.com/nullxception). This project is [BSD 3-Clause License](LICENSE) licensed.
