#!/bin/bash

username=$1
groupname="jupyterhub"

cp -rn /srv/jupyterhub/notebooks/ /home/$username/
chown -R $username:$groupname /home/$username/notebooks/
