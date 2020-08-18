docker build -t fred921/multi-client:latest -t fred921/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fred921/multi-server:latest -t fred921/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fred921/multi-worker:latest -t fred921/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fred921/multi-client:latest
docker push fred921/multi-server:latest
docker push fred921/multi-worker:latest

docker push fred921/multi-client:$SHA
docker push fred921/multi-server:$SHA
docker push fred921/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fred921/multi-server:$SHA
kubectl set image deployments/client-deployment client=fred921/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fred921/multi-worker:$SHA
