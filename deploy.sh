docker build -t blackflame007/multi-client:latest -t blackflame007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t blackflame007/multi-server:latest -t blackflame007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t blackflame007/multi-worker:latest -t blackflame007/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push blackflame007/multi-client:latest
docker push blackflame007/multi-server:latest
docker push blackflame007/multi-worker:latest

docker push blackflame007/multi-client:$SHA
docker push blackflame007/multi-server:$SHA
docker push blackflame007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=blackflame007/multi-server:$SHA
kubectl set image deployments/client-deployment client=blackflame007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=blackflame007/multi-worker:$SHA