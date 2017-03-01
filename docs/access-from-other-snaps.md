---
title: "Access PulseAudio From Other Snaps"
table_of_contents: True
---

# Access PulseAudio From Other Snaps

To allow other snaps to play or record audio by using the PulseAudio service
the *pulseaudio* interface exists which can be used to get access to features
PulseAudio offers. Apart from using the *pulseaudio* interface a few other things
need to be considered in order to get playback or recording working. These are

 1. Define a pulseaudio interface plug for your application in the applications
    snapcraft.yaml.
 2. Set necessary environment variables for each application which communicates
    with PulseAudio.

## Define Pulseaudio Interface Plug

To use the *pulseaudio* interface you simply need to define a plug with it
in your *snapcraft.yaml* for all relevant applications:

```
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

In order to talk with the PulseAudio service you need to set one environment variable
to ensure that libpulse finds the socket and other files it requires to talk to
the service. The environment variable you need to set is the following:

```
PULSE_RUNTIME_PATH=/var/run/pulse
```

This can be included in the snapcraft.yaml or in shell scripts you use as wrappers
around your programs. In our example we will directly include it in the *snapcraft.yaml* file:

```
name: my-audio-snap
[...]
apps:
  player:
    command: PULSE_RUNTIME_PATH=/var/run/pulse bin/player
    plugs:
      - pulseaudio
[...]
```
