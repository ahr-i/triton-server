# Triton Server Stable-Diffusion

## 1. Auto Docker start
### 1.1 Download
```
git clone https://github.com/ahr-i/triton-server.git
```

### 1.2 Auto start
```
cd triton-server
bash ./auto_start.sh
```

### 1.2.1 Error
If you encounter the error '$'\r': command not found', please use the following command.
```
sed -i 's/\r$//' ./auto_start.sh
```

<br />
<br />
<br />

## 2. Manual Docker start
### 2.1 Download
```
git clone https://github.com/ahr-i/triton-server.git
```

### 2.2 Docker build
```
cd triton-server
docker build -t tritonserver .
```

### 2.3 Docker run
```
docker network create --driver bridge --subnet=100.0.0.0/24 triton
docker run -d --name tritonserver --rm --gpus all --shm-size 16384m --network triton --ip 100.0.0.2 -p 8000:8000 -p 8022:22 -v $PWD/models:/models tritonserver
```

### 2.4 Attach
```
ssh root@localhost -p 8022
# password: ahri
```

### 2.5 Server start
```
/opt/tritonserver/bin/tritonserver --model-repository /models/test
```
