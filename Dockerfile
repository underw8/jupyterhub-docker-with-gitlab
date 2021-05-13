# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook:5cb007f03275

USER root
# Install an editor and curl
RUN apt-get update && apt-get install nano curl -y && \
    rm -rf /var/lib/apt/lists/* && \
    conda install -c conda-forge/label/main jupyterhub=1.3.0 -y && \
    pip install --no-cache oauthenticator==0.12.3 jupyterlab-gitlab==2.0.0 && \
    echo 'NAME_REGEX="^[a-z][-.a-z0-9_]*$"' >> /etc/adduser.conf

COPY ./userlist /srv/jupyterhub/userlist

COPY ./jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

COPY ./bootstrap.sh /srv/jupyterhub/bootstrap.sh
RUN chmod +x /srv/jupyterhub/bootstrap.sh

COPY ./notebooks/ /srv/jupyterhub/notebooks/

