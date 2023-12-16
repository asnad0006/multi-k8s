docker build -t asnad0006/multi-client-k8s:latest -t asnad0006/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t asnad0006/multi-server-k8s:latest -t asnad0006/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t asnad0006/multi-worker-k8s:latest -t asnad0006/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push asnad0006/multi-client-k8s:latest
docker push asnad0006/multi-server-k8s:latest
docker push asnad0006/multi-worker-k8s:latest

docker push asnad0006/multi-client-k8s:$SHA
docker push asnad0006/multi-server-k8s:$SHA
docker push asnad0006/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=asnad0006/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=asnad0006/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=asnad0006/multi-worker-k8s:$SHA