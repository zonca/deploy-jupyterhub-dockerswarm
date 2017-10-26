docker service create \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=/etc/jupyterhub,dst=/srv/jupyterhub \
  --mount src=nfsvolume,dst=/var/nfs \
  --name jupyterhubserver \
  --network jupyterhub \
  --constraint 'node.role == manager' \
  --detach=true \
  yourusername/jupyterhub-docker:latest
