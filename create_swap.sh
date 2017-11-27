#!/bin/sh

# size of the swapfile in megabytes
swapsize=8000

# check if the swap file already exist
grep -q "swapfile" /etc/fstab

# if not then create it
if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding the swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes were made.'
fi

# display output on terminal
df -h
cat /proc/swaps
cat /proc/meminfo | grep Swap