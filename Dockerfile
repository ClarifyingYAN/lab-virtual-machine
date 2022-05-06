FROM ubuntu:20.04

LABEL org.opencontainers.image.authors="cyan"

ARG user=cyan

# ssh http https
EXPOSE 22
EXPOSE 80
EXPOSE 443

# other for lab
EXPOSE 10000
EXPOSE 10001/UDP

# ENV BLOCK
ENV MY_CONTAINER_NAME=my_containter

# COPY file from source to dest
#
# COPY source dest
#
# ADD file from source to dest, it will auto extract zip file,
# and the source can be url
#
# ADD source dest
#
# set user
# USER daemon:usergroup

WORKDIR /tmp
RUN yes | unminimize
RUN apt -y update
RUN apt -y install \
    man \
    less \
    vim

RUN groupadd -r ${user} \
    && useradd -r -m -g ${user} ${user}
RUN echo -e "US\nEastern" | apt -y install openssh-server \
    && mkdir /run/sshd

USER ${user}
RUN mkdir -p /home/${user}/.ssh \
    && touch /home/${user}/.ssh/authorized_keys \
    && chmod 600 /home/${user}/.ssh/authorized_keys

USER root
RUN apt clean

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]

# volume ./data/

