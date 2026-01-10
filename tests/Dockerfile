FROM ubuntu:24.04

# Build-time arguments with defaults
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -y sudo curl git -qq && \
    rm -rf /var/lib/apt/lists/*

# Create or modify group
RUN if getent group ${USERNAME} > /dev/null 2>&1; then \
        groupmod -g ${GROUP_ID} ${USERNAME} || true; \
    else \
        groupadd -g ${GROUP_ID} ${USERNAME} || true; \
    fi

# Create or modify user
RUN if id ${USERNAME} > /dev/null 2>&1; then \
        usermod -u ${USER_ID} -g ${GROUP_ID} ${USERNAME} || true; \
    else \
        useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash ${USERNAME}; \
    fi

RUN mkdir -p /home/${USERNAME}/.local/state/dev-ubuntu-setup && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.local

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure the home directory is still owned by the (now updated) user
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}