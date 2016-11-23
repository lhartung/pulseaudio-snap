#!/bin/sh

wait_for_pulseaudio() {
	while ! systemctl status snap.pulseaudio.pulseaudio ; do
		sleep 1
	done
	sleep 1
}

