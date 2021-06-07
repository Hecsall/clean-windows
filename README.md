# Clean windows

Bunch of scripts useful to clean a fresh windows install.\
This is for my personal use, but feel free to copy or edit it to match your needs, just make sure you know what you are doing.

> `2020-DeCrapify.ps1` is a pretty heavy cleanup script forked from other repos, but I think it's pretty outdated, not everything works, and some things don't even exist.
    Also after using it I had strange issues with Xbox chat, so i stopped using this script.


## **My common usage**
Using powershell as admin:
```sh
.\enhancements.ps1
```
This will let you select some minor tweaks I usually make on new installations, like setting pointer speed to 1:1 and disabling accelleration, disable audio ducking etc.

Then
```sh
.\software-install.ps1
```
This will install Chocolatey package manager and let you select some softwares I usually install.

