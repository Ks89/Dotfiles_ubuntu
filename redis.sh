#!/bin/bash

#The MIT License (MIT)
#
#Copyright (c) 2016 Stefano Cappa
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.

#ONLY FOR Ubuntu
#DON'T EXECUTE THIS - BUT USE install.sh, please

# Taken from https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04

read -p "Would you install redis-server? Press y or n: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo installing redis server
  sudo apt-get update
  sudo apt-get install build-essential tcl
  cd /tmp
  curl -O http://download.redis.io/redis-stable.tar.gz
  tar xzvf redis-stable.tar.gz
  cd redis-stable
  make
  make test
  sudo make install
  sudo mkdir /etc/redis
  sudo cp /tmp/redis-stable/redis.conf /etc/redis
  sudo cp redis.conf /etc/redis/redis.conf

  # sudo nano /etc/systemd/system/redis.service

  sudo cp redis.service /etc/systemd/system/redis.service

  sudo adduser --system --group --no-create-home redis
  sudo mkdir /var/lib/redis
  sudo chown redis:redis /var/lib/redis
  sudo chmod 770 /var/lib/redis
  sudo systemctl start redis
  sudo systemctl status redis
  # press q
  #redis-cli
  sudo systemctl restart redis
  #redis-cli
  sudo systemctl enable redis
fi
