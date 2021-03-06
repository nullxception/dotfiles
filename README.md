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
  ./install.sh <topic_name>
  ```

* Windows (from pwsh)

  ```powershell
  .\install.ps1 <topic_name>
  ```

and that's pretty much it 😊

## 📑 Topic Structures
As you can see, this dotfiles is grouped by topics.

Each of it has their own `.module-data` (either ended with `.bash` or `.ps1`, depending on the OS target) files that will be used by the install script.

For complete example, take a look at [`.module-data.bash.example`](.module-data.bash.example) and [`.module-data.ps1.example`](.module-data.ps1.example) files in the root directory of this repository.

## 💬 FAQ

🤔: _Can I use it on my machine ?_

For some topic like `shell` or `firefox`, yes.

But for `etc` topic, I don't think you want to install it blatantly, since it's a system configuration, tho you can still use it as a references (maybe ?) :)

🤔: _Why don't use ansible/stow/yadm/etc instead ?_

For simple task such installing files, I think shell script (bash/pwsh) is more than enough for me.

🤔: _Is there any LDA or r/unixporn-able desktop suite configuration here ?_

I'm just your regular desktop-environment neighbor (ATM) :)

## 📄 License

Copyright © 2019 [Nauval Rizky](https://github.com/nullxception). This project is [BSD 3-Clause License](LICENSE) licensed.
