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
apt update
apt upgrade --yes --force-yes
apt install -y --force-yes snapcraft
cd /home/pulseaudio
snapcraft clean
snapcraft
EOF
chmod +x /home/test/build-snap.sh
sudo classic /home/test/build-snap.sh
snap remove classic

# Make sure we have a snap build
test -e /home/pulseaudio/pulseaudio_*_amd64.snap
