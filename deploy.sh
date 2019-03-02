docker image build -t mbendahan/multi-client:latest -t mbendahan/multi-client:$SHA -f ./client/Dockerfile ./client
docker image build -t mbendahan/multi-server:latest -t mbendahan/multi-server:$SHA -f ./server/Dockerfile ./server
docker image build -t mbendahan/multi-worker:latest -t mbendahan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker image push mbendahan/multi-client:latest
docker image push mbendahan/multi-client:$SHA

docker image push mbendahan/multi-server:latest
docker image push mbendahan/multi-server:$SHA

docker image push mbendahan/multi-worker:latest
docker image push mbendahan/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=mbendahan/multi-client:$SHA
kubectl set image deployments/server-deployment server=mbendahan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mbendahan/multi-worker:$SHA