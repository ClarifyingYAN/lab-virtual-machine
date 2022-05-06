FROM ubuntu:20.04

LABEL org.opencontainers.image.authors="cyan"

ARG user=cyan
ARG root_passwd=123456

# EXPOSE only used for document, use -p in practice
# ssh http https
EXPOSE 22
EXPOSE 80
EXPOSE 443
# other for lab
EXPOSE 10000
EXPOSE 10001/UDP

# ENV BLOCK
ENV MY_CONTAINER_NAME=my_containter
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
RUN yes | unminimize
RUN apt -y update \
    && apt -y install \
        man \
        less \
        vim \
        sudo \
        openssh-server \
        golang
RUN echo "root:${root_passwd}" | chpasswd

RUN groupadd -r ${user} \
    && useradd -r -m -g ${user} ${user} \
    && chsh -s /bin/bash ${user} \
    && mkdir /run/sshd

USER ${user}
RUN mkdir -p /home/${user}/.ssh \
    && touch /home/${user}/.ssh/authorized_keys \
    && chmod 600 /home/${user}/.ssh/authorized_keys

ADD --chown=${user}:${user} https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-aarch64.sh /home/${user}/
RUN bash /home/${user}/Miniconda3-py39_4.11.0-Linux-aarch64.sh -b \
    && rm /home/${user}/Miniconda3-py39_4.11.0-Linux-aarch64.sh \
    && /home/${user}/miniconda3/bin/conda init \
    && /home/${user}/miniconda3/bin/conda config --set auto_activate_base false

USER root
RUN apt clean

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]
