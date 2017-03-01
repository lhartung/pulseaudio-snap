#!/bin/bash

# We don't have to build a snap when we should use one from a
# channel
if [ -n "$SNAP_CHANNEL" ] ; then
	exit 0
fi

# Setup classic snap and build the pulseaudio snap in there
snap install --devmode --beta classic
cat <<-EOF > /home/test/build-snap.sh
#!/bin/sh
set -ex

export DEBIAN_FRONTEND=noninteractive

# If there is a snap prebuilt for us, lets take that one to speed things up.
if [ -e $PROJECT_PATH/${SNAP_NAME}_*_${SNAP_ARCH}.snap ] ; then
	exit 0
fi

# FIXME: Enable propose for now until problems with conflicting systemd
# packages between the Ubuntu Core image ppa and the archive are fixed.
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-proposed restricted main universe" > /etc/apt/sources.list.d/ubuntu-proposed.list
echo "deb http://ppa.launchpad.net/snappy-dev/image/ubuntu xenial main" > /etc/apt/sources.list.d/ubuntu-image-ppa.list

# Ensure we have the latest updates installed as the core snap
# may be a bit out of date.
apt update
apt -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' full-upgrade -y --force-yes

apt install -y --force-yes snapcraft
cd /home/pulseaudio
snapcraft clean
snapcraft
EOF

chmod +x /home/test/build-snap.sh
sudo classic /home/test/build-snap.sh
snap remove classic

# Make sure we have a snap build
test -e /home/pulseaudio/${SNAP_NAME}*_${SNAP_ARCH}.snap
