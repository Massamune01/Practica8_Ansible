FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar SSH y sudo
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd

# Crear usuario ansible
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    usermod -aG sudo ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Permitir login por password
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Exponer puerto SSH
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]