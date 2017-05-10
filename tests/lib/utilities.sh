#!/bin/sh

wait_for_pulseaudio() {
	while ! systemctl status snap.pulseaudio.pulseaudio ; do
		sleep 1
	done
	sleep 1
}

install_snap_under_test() {
	# If we don't install the snap here we get a system
	# without any network connectivity after reboot.
	if [ -n "$SNAP_CHANNEL" ] ; then
		# Don't reinstall if we have it installed already
		if ! snap list | grep $SNAP_NAME ; then
			snap install --$SNAP_CHANNEL $SNAP_NAME
		fi
	else
		# Install first from store to avoid error when performing the connection
		snap install $SNAP_NAME
		# Install prebuilt snap
		snap install --dangerous ${PROJECT_PATH}/${SNAP_NAME}_*_${SNAP_ARCH}.snap
	fi
	if [ -n "$SNAP_AUTO_ALIASES" ]; then
		snapd_version=$(snap version | awk '/^snapd / {print $2; exit}')
		for alias in $SNAP_AUTO_ALIASES ; do
			target=$SNAP_NAME.$alias
			if dpkg --compare-versions $snapd_version lt 2.25 ; then
				target=$SNAP_NAME
			fi
			snap alias $target $alias
		done
	fi
}
