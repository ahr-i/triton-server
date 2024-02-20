FROM nvcr.io/nvidia/tritonserver:23.12-py3

# Install required packages.
RUN pip install torch==1.12.1 --extra-index-url https://download.pytorch.org/whl/cu116
RUN pip install --upgrade diffusers==0.2.4 scipy==1.9.1 transformers==4.21.2

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Set password
RUN echo 'root:ahri' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Start SSH server
CMD service ssh start && tail -f /dev/null