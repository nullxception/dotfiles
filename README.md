<p align="center">
  <img src="https://user-images.githubusercontent.com/58150791/71537208-ffe23900-295b-11ea-841b-318adfe977d8.png" />
</p>
<p align="center">
  <a href="LICENSE" target="_blank">
    <img alt="License: BSD 3--Clause License" src="https://img.shields.io/badge/License-BSD 3--Clause License-yellow.svg" />
  </a>
  <a href="https://twitter.com/nullxception" target="_blank">
    <img alt="Twitter: nullxception" src="https://img.shields.io/twitter/follow/nullxception.svg?style=social" />
  </a>
</p>

> nullxception's desktop and other configurations

## What the heck is this

This is a dotfiles repo, which is a set of some configurations that commonly used by me on my desktop and server.

It was supposed to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup.
So, don't be shy, give a ⭐️ if some configs can helps you :)

## Structures

I'm not an expert in abstraction-stuff.
So, as you can see, the structures are pretty simple :

```
<module-name>/install.sh
```
Just like the name, it's a simple shell script that will process/copy required files/folders to the destination that already setted-up inside the script.

```
<module-name>/files/*
```
The files and folders inside of it are supposed to be things that `install.sh` would be processed/copied to the actual destination, such as actual configuration, encrypted blobs, etc.

## License

Copyright © 2019 [Nauval Rizky](https://github.com/nullxception). This project is [BSD 3-Clause License](LICENSE) licensed.
