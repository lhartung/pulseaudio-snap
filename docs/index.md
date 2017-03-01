---
title: "PulseAudio"
table_of_contents: False
---

# About PulseAudio

PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your
sound applications. It allows you to do advanced operations on your sound data
as it passes between your application and your hardware. Things like transferring
the audio to a different machine, changing the sample format or channel count and
mixing several sounds into one are easily achieved using a sound server.

PulseAudio is an integral part of all relevant modern Linux distributions and used
in various mobile devices by multiple vendors.

## What PulseAudio Offers

 * Extensible plugin architecture (by loading dynamic loadable modules with dlopen())
 * Support for static linking of modules, allowing a single binary for all your needs
 * Module autoloading
 * Support for more than one sink/source
 * Good low latency behaviour
 * Very accurate latency measurement for playback and recording.
 * Client side latency interpolation
 * Embeddable into other software (the core is available as C library)
 * Completely asynchronous C API, complemented by two synchronous variants for simple use in synchronous applications
 * Simple command line interface for reconfiguring the daemon while running
 * Flexible, implicit sample type conversion and resampling
 * "Zero-Copy" architecture
 * May be used to combine multiple sound cards to one (with sample rate adjustment)
 * Ability to fully synchronize multiple playback streams
 * Various network audio streaming options

Please see [the upstream feature list](https://www.freedesktop.org/wiki/Software/PulseAudio/About/) for more details.

## Upstream documentation

Existing documentation from the upstream project can be found
[here](https://www.freedesktop.org/wiki/Software/PulseAudio/).
