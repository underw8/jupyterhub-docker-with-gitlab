# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook:hub-4.0.2

USER root

RUN apt-get update && apt-get install nano curl -y && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache oauthenticator==16.1.0 jupyterlab-gitlab==4.0.0 jupyter-collaboration==1.2.0

RUN echo 'NAME_REGEX="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"' >> /etc/adduser.conf

COPY ./userlist /srv/jupyterhub/userlist

COPY ./jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

RUN groupadd jupyterhub

COPY ./bootstrap.sh /srv/jupyterhub/bootstrap.sh
RUN chmod +x /srv/jupyterhub/bootstrap.sh

COPY ./notebooks/ /srv/jupyterhub/notebooks/
