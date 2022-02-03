docker build -t etcd-windows-image . && mkdir -p c:/temp/etcd-data.tmp && \
  docker run \
  -p 2379:2379 \
  -p 2380:2380 \
  --mount type=bind,source=c:/temp/etcd-data.tmp,destination=c:/etcd-data \
  --name etcd-gcr \
  etcd-windows-image:latest \
  c:/temp/bin/etcd \
  --name s1 \
  --data-dir c:/etcd-data \
  --listen-client-urls http://127.0.0.1:2379 \
  --advertise-client-urls http://127.0.0.1:2379 \
  --listen-peer-urls http://127.0.0.1:2380 \
  --initial-advertise-peer-urls http://127.0.0.1:2380 \
  --initial-cluster s1=http://127.0.0.1:2380 \
  --initial-cluster-token tkn \
  --initial-cluster-state new \
  --log-level info \
  --logger zap \
  --log-outputs stderr

docker exec etcd-gcr /bin/bash -c "c:/temp/bin/etcd --version"
docker exec etcd-gcr /bin/bash -c "c:/temp/bin/etcdctl version"
docker exec etcd-gcr /bin/bash -c "c:/temp/bin/etcdctl endpoint health"
docker exec etcd-gcr /bin/bash -c "c:/temp/bin/etcdctl put foo bar"
docker exec etcd-gcr /bin/bash -c "c:/temp/bin/etcdctl get foo"
docker exec etcd-gcr /bin/bash -c "c:/temp/bin/etcdutl version"

docker stop etcd-gcr
docker rm etcd-gcr
docker rmi etcd-windows-image
