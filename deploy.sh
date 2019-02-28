docker build -t adityakarnik/multi-client:latest -t adityakarnik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adityakarnik/multi-server:latest -t adityakarnik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adityakarnik/multi-worker:latest -t adityakarnik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adityakarnik/multi-client:latest
docker push adityakarnik/multi-server:latest
docker push adityakarnik/multi-worker:latest

docker push adityakarnik/multi-client:$SHA
docker push adityakarnik/multi-worker:$SHA
docker push adityakarnik/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=adityakarnik/multi-server:$SHA
kubectl set image deployment/client-deployment server=adityakarnik/multi-client:$SHA
kubectl set image deployment/worker-deployment server=adityakarnik/multi-worker:$SHA