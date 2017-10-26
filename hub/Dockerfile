FROM jupyterhub/jupyterhub:0.8.0

EXPOSE 8081

RUN /opt/conda/bin/pip install oauthenticator swarmspawner

# Install modified version of swarmspawner that creates user folders
#RUN /opt/conda/bin/pip install oauthenticator https://github.com/zonca/SwarmSpawner/archive/createfolder.zip
