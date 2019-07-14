docker build -t josephktcheung/multi-client:latest -t josephktcheung/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t josephktcheung/multi-server:latest -t josephktcheung/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t josephktcheung/multi-worker:latest -t josephktcheung/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push josephktcheung/multi-client:latest
docker push josephktcheung/multi-server:latest
docker push josephktcheung/multi-worker:latest
docker push josephktcheung/multi-client:$SHA
docker push josephktcheung/multi-server:$SHA
docker push josephktcheung/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=josephktcheung/multi-server:$SHA
kubectl set image deployments/client-deployment client=josephktcheung/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=josephktcheung/multi-worker:$SHA
