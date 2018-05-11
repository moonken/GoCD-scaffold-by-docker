FROM registry.docker-cn.com/gocd/gocd-agent-centos-7:v18.3.0

################# Do not change this section ####################
RUN mkdir /go
COPY --chown=go:go .ssh /home/go/.ssh
USER go
RUN mkdir /home/go/shared
USER root

################# Install tools in this section #################
#RUN yum -y --enablerepo=extras install epel-release && yum -y install make gcc libpng-devel python-pip && yum clean all
#RUN pip install docker-compose --force --upgrade
#RUN curl -L https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine
#RUN install /tmp/docker-machine /usr/local/bin/docker-machine
#RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-18.03.0-ce.tgz" && \
#    tar xzvf docker.tgz && \
#    cp docker/docker /usr/local/bin/ && \
#    rm -rf docker && \
#    rm -rf docker.tgz
#USER go
#RUN pip install awscli --upgrade --user
#RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
#RUN /bin/bash -c "source $HOME/.bashrc && nvm install v8.1.4 && npm install yarn -g"
##################################################################

#USER root
