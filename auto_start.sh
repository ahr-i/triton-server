echo "* (SCRIPT) Execute the auto start shell script."

echo "* (SCRIPT) Docker build."
docker build -t tritonserver .
if [ $? -ne 0 ]; then
	echo "*** (ERROR) Is Docker running?"
	exit 1
fi
echo "* (SCRIPT) Docker build success!"

echo "* (SCRIPT) Docker network create."
docker network create --driver bridge --subnet=100.0.0.0/24 triton

echo "* (SCRIPT) Docker start."
docker run -d --name tritonserver --rm --gpus all --shm-size 16384m --network triton --ip 100.0.0.2 -p 8000:8000 -p 8022:22 -v $PWD/models:/models tritonserver
if [ $? -ne 0 ]; then
	docker stop tritonserver
	docker run -d --name tritonserver --rm --gpus all --shm-size 16384m --network triton --ip 100.0.0.2 -p 8000:8000 -p 8022:22 -v $PWD/models:/models tritonserver
	if [ $? -ne 0 ]; then
	echo "*** (ERROR) Is Docker running?"
	exit 1
	fi
	echo "* (SCRIPT) Docker container restart."
fi
echo "* (SCRIPT) Docker start success!"

sleep 5

echo "* (SCRIPT) Triton server start."
HOST="localhost"
PORT="8022"
USER="root"
PASSWORD="ahri"
COMMAND="nohup /opt/tritonserver/bin/tritonserver --model-repository /models/test > /dev/null 2>&1 & exit"
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $PORT $USER@$HOST "$COMMAND"

echo "* (SCRIPT) Auto start success."