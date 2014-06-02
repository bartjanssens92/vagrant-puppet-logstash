#!/bin/bash
echo "########################"
echo "# Get the dependencies #"
echo "########################"
sudo yum install libpcap daemonize -y

echo "###################"
echo "# Get the package #"
echo "###################"
curl -L -O https://github.com/packetbeat/packetbeat/releases/download/v0.1.1/packetbeat-0.1.1-1.el6.x86_64.rpm

echo "######################"
echo "# Unpack the package #"
echo "######################"
sudo rpm -vi packetbeat-0.1.1-1.el6.x86_64.rpm

echo "#################"
echo "# Remove the DL #"
echo "#################"
rm -rf packetbeat-0.1.1-1.el6.x86_64.rpm