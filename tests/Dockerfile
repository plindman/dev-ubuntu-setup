FROM ubuntu:24.04

# Build-time arguments with defaults
ARG USER_ID=1000
ARG GROUP_ID=1000

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -y sudo curl git -qq && \
    # Adjust the existing 'ubuntu' user to match the host UID/GID
    # We use '|| true' because if the IDs are already 1000, these might exit with 0 or a warning
    groupmod -g ${GROUP_ID} ubuntu || true && \
    usermod -u ${USER_ID} -g ${GROUP_ID} ubuntu || true && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/ubuntu/.local/state/dev-ubuntu-setup && \
    chown -R ubuntu:ubuntu /home/ubuntu/.local

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure the home directory is still owned by the (now updated) ubuntu user
RUN chown -R ubuntu:ubuntu /home/ubuntu

USER ubuntu
WORKDIR /home/ubuntu