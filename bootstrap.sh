#!/usr/bin/env bash

USER=vagrant

#Remove puppet and chef to lower memory usage
apt-get remove chef puppet -y
pkill chef-client


#Make sure the system and the package database are both up to date
echo "Updating"
apt-get update -y
#apt-get upgrade -y

#Start installing the needed software to set things up
apt-get install -y htop virtualenv python-pip
pip install virtualenvwrapper

#Set up the virtual environment

if [ -z "$WORKON_HOME" ]; then
    WORKON_DIR=/var/local/virtual_environments_workon/
    echo "WORKON_HOME=$WORKON_DIR" >> /etc/profile
fi

if [ -z "$PROJECT_HOME" ]; then
    PROJECT_DIR=/var/local/virtual_environments/
    echo "PROJECT_HOME=$PROJECT_DIR" >> /etc/profile
fi

echo "source /usr/local/bin/virtualenvwrapper.sh" >> /etc/profile

#Allow ourselves to use the previous variables now
source /etc/profile

if [ ! -d "$WORKON_DIR" ]; then
    mkdir -p $WORKON_DIR
fi

if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p $PROJECT_DIR
fi

source /usr/local/bin/virtualenvwrapper.sh

chown -R vagrant /var/local/virtual_environments_workon/
chown -R vagrant /var/local/virtual_environments/

#Virtual environment is now setup, I can start installing things into this now
mkvirtualenv projman -p /usr/bin/python3
