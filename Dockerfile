FROM madduci/docker-linux-cpp:latest

LABEL license="Copyright (c) 2012-2021, Matt Godbolt"

EXPOSE 10240

RUN echo "*** Installing Compiler Explorer ***" \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y \
        wget \
        ca-certificates \
        nodejs \
        make \
        git

RUN wget https://raw.githubusercontent.com/RobotLocomotion/drake/v1.1.0/setup/ubuntu/binary_distribution/packages-focal.txt
RUN xargs apt-get install -y < packages-focal.txt

RUN apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/cache/apt/*


RUN git clone https://github.com/compiler-explorer/compiler-explorer.git /opt/compiler-explorer

RUN echo "*** Add missing dependencies of compiler-explorer ***"
WORKDIR /opt/compiler-explorer
RUN npm i @sentry/node \
    npm run webpack

RUN echo "*** Add drake ***"
WORKDIR /tmp
ARG drake_tarball_name="drake-20220328-focal.tar.gz"
RUN wget https://github.com/RobotLocomotion/drake/releases/download/v1.1.0/$drake_tarball_name
RUN tar -xzf $drake_tarball_name -C /opt

RUN rm /tmp/* -rf

WORKDIR /opt/compiler-explorer
ADD cpp.properties /opt/compiler-explorer/etc/config/c++.local.properties

ENTRYPOINT [ "make" ]

CMD ["run"]
