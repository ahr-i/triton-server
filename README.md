# Triton Server Stable-Diffusion

## 1. Docker start
### 1.1 Download
```
git clone https://github.com/ahr-i/triton-server.git
```

### 1.2 Docker build
```
cd triton-server
docker build -t tritonserver .
```

### 1.3 Docker run
```
docker network create --driver bridge --subnet=100.0.0.0/24 triton
docker run -d --name tritonserver --rm --gpus all --shm-size 16384m --network triton --ip 100.0.0.2 -p 8000:8000 -p 8022:22 -v $PWD/models:/models tritonserver
```

### 1.4 Attach
```
ssh root@localhost -p 8022
# password: ahri
```

### 1.5 Server start
```
/opt/tritonserver/bin/tritonserver --model-repository /models/test
```
