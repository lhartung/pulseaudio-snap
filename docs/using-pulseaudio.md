---
title: "Using PulseAudio"
table_of_contents: True
---

# Using PulseAudio

## PulseAudio Daemon

After install of pulseaudio snap, the pulseaudio daemon should be up and
running.  We can check its status with systemctl, and something similar to

```text
$ systemctl status snap.pulseaudio.pulseaudio.service | cat
● snap.pulseaudio.pulseaudio.service - Service for snap application pulseaudio.pulseaudio
   Loaded: loaded (/etc/systemd/system/snap.pulseaudio.pulseaudio.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2017-03-10 08:09:05 UTC; 2min 10s ago
 Main PID: 1242 (pulseaudio)
   CGroup: /system.slice/snap.pulseaudio.pulseaudio.service
           ├─1242 /bin/sh /snap/pulseaudio/9/bin/pulseaudio
           └─1276 /snap/pulseaudio/9/usr/bin/pulseaudio --exit-idle-time=-1 --disallow-exit=yes --disallow-module-loading --system -F /snap/pulseaudio/9/etc/pulse/default.pa -p /snap/pulseaudio/9/usr/lib/pulse-8.0/modules -n
```

should be displayed.

## PulseAudio Utils

The snap also includes some core pulseaudio utilities:
[pactl](http://manpages.ubuntu.com/manpages/zesty/en/man1/pactl.1.html),
[paplay](http://manpages.ubuntu.com/manpages/zesty/en/man1/paplay.1.html) and
[parec](http://manpages.ubuntu.com/manpages/zesty/en/man1/parec.1.html).  Usage
is as normally expected (check the linked man pages), but we need to take into
account that we are running PA in system mode and we need root permissions when
accessing it. This also implies that files need to be in some place which
belongs to root and that can be accessed by the snap, like
[$SNAP_COMMON](https://snapcraft.io/docs/reference/env). For instance, if we
want to play an audio file that we have in our home folder with paplay, the
command would be similar to

```text
$ sudo cp <audio-file> /var/snap/pacat-simple/common/
$ sudo paplay /var/snap/pacat-simple/common/<audio-file>
```

The same appplies to the rest of the commands.
