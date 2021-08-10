docker build -t jeffhogg86/multi-client:latest -t jeffhogg86/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffhogg86/multi-server:latest -t jeffhogg86/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffhogg86/multi-worker:latest -t jeffhogg86/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jeffhogg86/multi-client:latest
docker push jeffhogg86/multi-server:latest
docker push jeffhogg86/multi-worker:latest
docker push jeffhogg86/multi-client:$SHA
docker push jeffhogg86/multi-server:$SHA
docker push jeffhogg86/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeffhogg86/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeffhogg86/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeffhogg86/multi-worker:$SHA