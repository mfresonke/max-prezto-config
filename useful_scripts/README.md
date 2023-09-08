## Wirepusher

```
# make wirepusher a global command
sudo ln -s ~/.zprezto/useful_scripts/wirepusher /usr/local/bin/wirepusher

# function for apc script
wallee() { tee >(xargs -I {} wirepusher "Power Failure Event" "{}") | wall }
sudo vim /etc/apcupsd/apccontrol
```
