docker build -t benwyse11/multi-client:latest -t benwyse11/multi-client:$SHA -f  ./client
docker build -t benwyse11/multi-server:latest -t benwyse11/multi-server:$SHA -f  ./server
docker build -t benwyse11/multi-worker:latest -t benwyse11/multi-worker:$SHA -f  ./worker

docker push benwyse11/multi-client:latest
docker push benwyse11/multi-server:latest
docker push benwyse11/multi-client:latest
docker push benwyse11/multi-client:$SHA
docker push benwyse11/multi-server:$SHA
docker push benwyse11/multi-client:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment client=benwyse11/multi-client:$SHA
kubectl set image deployment/server-deployment server=benwyse11/multi-server:$SHA
kubectl set image deployment/server-deployment worker=benwyse11/multi-worker:$SHA