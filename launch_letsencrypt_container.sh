docker run \
  --cap-add=NET_ADMIN \
  --name nginx \
  -p 443:443 \
  -p 80:80 \
  --detach \
  -e EMAIL=your_email@domain.edu \
  -e URL=your.domain.org \
  -v nginx_volume:/config \
  --network jupyterhub \
  --mount type=bind,src=/etc/jupyterhub/letsencrypt_container_nginx.conf,dst=/config/nginx/site-confs/default \
  linuxserver/letsencrypt
