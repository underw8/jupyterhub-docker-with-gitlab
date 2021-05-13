#!/bin/bash

username=$1

cp -rn /srv/jupyterhub/notebooks/ /home/$username/
chown -R $username:$username /home/$username/notebooks/