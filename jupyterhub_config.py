import os

from oauthenticator.google import GoogleOAuthenticator
c.JupyterHub.authenticator_class = GoogleOAuthenticator
c.GoogleOAuthenticator.oauth_callback_url = 'http://server_url.com/hub/oauth_callback'
c.GoogleOAuthenticator.client_id = ''
c.GoogleOAuthenticator.client_secret = ''

## The public facing port of the proxy
c.JupyterHub.port = 8000
## The public facing ip of the whole application (the proxy)
c.JupyterHub.ip = '0.0.0.0'
## The ip for this process
c.JupyterHub.hub_ip = '0.0.0.0'
#  Defaults to an empty set, in which case no user has admin access.
c.GoogleOAuthenticator.admin_users = {"youremail@gmail.com"}

c.JupyterHub.spawner_class = 'cassinyspawner.SwarmSpawner'
c.SwarmSpawner.jupyterhub_service_name = "jupyterhubserver"

c.SwarmSpawner.networks = ["jupyterhub"]

notebook_dir = os.environ.get('NOTEBOOK_DIR') or '/home/jovyan/work'
c.SwarmSpawner.notebook_dir = notebook_dir

mounts = [{'type': 'volume',
           'source': 'jupyterhub-user-{username}',
           'target': notebook_dir,
        'no_copy' : True,
        'driver_config' : {
          'name' : 'local',
          'options' : {
             'type' : 'nfs4',
             'o' : 'addr=SERVER_IP,rw',
             'device' : ':/var/nfs/{username}/'
           }
        },
}]

c.SwarmSpawner.container_spec = {
    # The command to run inside the service
    'args': ['/usr/local/bin/start-singleuser.sh'],  # (string or list)
    'Image': 'jupyter/datascience-notebook:latest',
    # Replace mounts with [] to disable permanent storage
    'mounts': mounts
}

c.SwarmSpawner.resource_spec = {
    # (int)  CPU limit in units of 10^9 CPU shares.
    'cpu_limit': int(1 * 1e9),
    # (int)  Memory limit in Bytes.
    'mem_limit': int(512 * 1e6),
    # (int)  CPU reservation in units of 10^9 CPU shares.
    'cpu_reservation': int(1 * 1e9),
    # (int)  Memory reservation in bytes
    'mem_reservation': int(512 * 1e6),
}
