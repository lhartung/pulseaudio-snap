---
title: "Access PulseAudio From Other Snaps"
table_of_contents: True
---

# Access PulseAudio From Other Snaps

To allow other snaps to play or record audio, or to use other PulseAudio
features, the *pulseaudio* interface must be used.  Apart from using this
interface, a few other things need to be considered in order to get playback or
recording working. These are

 1. Define a pulseaudio interface plug for your application in the application
    snapcraft.yaml.
 2. Set necessary environment variables for each application which communicates
    with PulseAudio.

## Define Pulseaudio Interface Plug

To use the *pulseaudio* interface you need first to define a plug with it
in your *snapcraft.yaml* for all relevant applications:

```text
name: my-audio-snap
[...]
apps:
  player:
    command: bin/player
    plugs:
      - pulseaudio
[...]
```

With this, the plug will be listed by *snap interfaces* once you installed your
snap. You can connect it to the PulseAudio service via:

```
$ snap connect my-audio-snap:pulseaudio pulseaudio:service
```

Now the interface connection between your client snap and the service is established.

## Set Necessary Environment Variables

In order to talk with the PulseAudio service you need to set two environment
variables to ensure that libpulse finds the socket and other files it requires
to talk to the service. The environment variables are the following:

```text
PULSE_RUNTIME_PATH=/var/run/pulse
PULSE_SYSTEM=1

```

This can be included in the snapcraft.yaml or in shell scripts you can use as
wrappers around your programs.

## Example Program

To illustrate these concepts, it is worth looking this
[small example](https://github.com/canonical-system-enablement/pulseaudio-example)
that uses libpulse and that integrates properly with Ubuntu Core.

You can compile and install following the instrucstions in its
[README file](https://github.com/canonical-system-enablement/pulseaudio-example).

The [snapcraft.yaml](https://github.com/canonical-system-enablement/pulseaudio-example/blob/master/snapcraft.yaml)
file contains this information:

```text
apps:
  pulseaudio-example:
    command: bin/client-wrapper usr/bin/pulseaudio-example
    plugs:
      - pulseaudio
      - home
```

Which shows that we are using the pulseaudio flag and a wrapper.
[The wrapper](https://github.com/canonical-system-enablement/pulseaudio-example/blob/master/overlay/bin/client-wrapper)
sets the expected variables:

```text
export PULSE_RUNTIME_PATH=/var/run/pulse
export PULSE_SYSTEM=1
```

An important thing to note is that using PulseAudio needs root permission in
Core, so you need to put the audio files in some place which belongs to root and
that can be accessed by the snap, for instance $SNAP_COMMON, which would be
/var/snap/pacat-simple/common in the example snap.
