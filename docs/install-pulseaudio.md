---
title: "Install PulseAudio"
table_of_contents: True
---

# Install PulseAudio

The PulseAudio snap is available from the Ubuntu Store. It can be installed on
any system that supports snaps but is only recommended on
[Ubuntu Core](https://www.ubuntu.com/core) at the moment.

You can install the snap with the following command:

```
 $ snap install pulseaudio
 pulseaudio 8.0-3 from 'canonical' installed
```

Although the pulseaudio snap is available from other channels (candidate, beta,
edge), only the stable version should be used for production devices. The
purpose of the other channels is for internal use for the development team of
the pulseaudio snap.

All necessary plugs and slots will be automatically connected within the
installation process. You can verify this with:

```
$ snap interfaces pulseaudio
Slot                Plug
:network            pulseaudio
pulseaudio:service  pulseaudio:client
-                   pulseaudio:home

```

Please note that we do not connect the home plug of the PulseAudio snap by
default.  This is because normally you will use another snap to play audio
through PulseAudio and then PulseAudio itself does not need any access to
something outside of its snap as the playing snap will submits its audio data
over network or memory based transport. If you want to use the included parec or
paplay utilities you have to connect the home plug as otherwise both can only
read/write data within the PulseAudio snap and nowhere else. You can connect it
via:

```
$ snap connect pulseaudio:home core
```

Now you have PulseAudio successfully installed.

## Next Steps

 * [Using PulseAudio](using-pulseaudio.md)
 * [Access from other snaps](access-from-other-snaps.md)
