## Wirepusher

```
wallee() { tee >(xargs -I {} wirepusher "Power Failure Event" "{}") | wall }
sudo vim /etc/apcupsd/apccontrol
```
