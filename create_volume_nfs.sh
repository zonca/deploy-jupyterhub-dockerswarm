docker volume create --driver local \
    --opt type=nfs4 \
    --opt o=addr=NFS_SERVER_IP,rw \
    --opt device=:/var/nfs \
    nfsvolume
