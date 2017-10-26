docker service create \
  --name nginx \
  --constraint 'node.role == manager' \
  --publish 80:80 \
  --detach=true \
  --network jupyterhub \
  --mount type=bind,src=/etc/nginx/nginx.conf,dst=/etc/nginx/conf.d/default.conf \
  nginx
