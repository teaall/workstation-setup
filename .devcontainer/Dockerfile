# kics-scan disable=b03a748a-542d-44f4-bb86-9199ab4fd2d5
FROM python:3.13-bookworm

ARG USER_GID=1000
ARG USER_UID=1000
ARG USERNAME=vscode

WORKDIR /workspace

# kics-scan ignore-block
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    build-essential \
    git \
    curl \
    ssh \
    locales \
    rsync \
    && rm -rf /var/lib/apt/lists/*

# locale settings
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales
ENV LANG=en_US.UTF-8do
ENV LC_ALL=en_US.UTF-8    

# Ansible
RUN --mount=type=bind,source=requirements.txt,target=/tmp/requirements.txt \
    pip install --no-cache-dir --requirement /tmp/requirements.txt

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME} \
    # Sudo Support
    && echo ${USERNAME} ALL=\(root\)\ NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}

# Entry point for container (adjust as needed)
CMD [ "bash" ]
