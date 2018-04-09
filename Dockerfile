FROM openjdk:8u151-jre-alpine

ARG ZK_VERSION=3.4.11

ENV SERVICE_VERSION=$ZK_VERSION \
    SERVICE_NAME=zk \
    SERVICE_HOME=/opt/zk \
    SERVICE_CONF=/opt/zk/conf/zoo.cfg \
    SERVICE_USER=zookeeper \
    SERVICE_UID=10002 \
    SERVICE_GROUP=zookeeper \
    SERVICE_GID=10002 \
    PATH=/opt/zk/bin:${PATH}

# Install service software
RUN SERVICE_RELEASE=zookeeper-${SERVICE_VERSION} && \
    mkdir -p ${SERVICE_HOME}/logs ${SERVICE_HOME}/data && \
    cd /tmp && \
    apk add --no-cache --virtual .fetch-deps jq gnupg tar patch  curl && \
    apk add --no-cache bash &&\
    eval $(gpg-agent --daemon) && \
    curl -sSLO "https://dist.apache.org/repos/dist/release/zookeeper/${SERVICE_RELEASE}/${SERVICE_RELEASE}.tar.gz" && \
    echo "https://dist.apache.org/repos/dist/release/zookeeper/${SERVICE_RELEASE}/${SERVICE_RELEASE}.tar.gz" && \
    curl -sSLO https://dist.apache.org/repos/dist/release/zookeeper/${SERVICE_RELEASE}/${SERVICE_RELEASE}.tar.gz.asc && \
    curl -sSL  https://dist.apache.org/repos/dist/release/zookeeper/KEYS | gpg -v --import - && \
    gpg -v --verify ${SERVICE_RELEASE}.tar.gz.asc && \
    tar -zx -C ${SERVICE_HOME} --strip-components=1 --no-same-owner -f ${SERVICE_RELEASE}.tar.gz && \
    apk del .fetch-deps && \
    mv ${SERVICE_HOME}/conf/zoo_sample.cfg ${SERVICE_HOME}/conf/zoo.cfg && \
    rm -rf \
      /tmp/* \
      /root/.gnupg \
      /var/cache/apk/* \
      ${SERVICE_HOME}/contrib/fatjar \
      ${SERVICE_HOME}/dist-maven \
      ${SERVICE_HOME}/docs \
      ${SERVICE_HOME}/src \
      ${SERVICE_HOME}/bin/*.cmd && \
    addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} && \
    adduser -g "${SERVICE_NAME} user" -D -h ${SERVICE_HOME} -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER}



WORKDIR ${SERVICE_HOME}
VOLUME "${SERVICE_HOME}"

COPY start-zk.sh /usr/bin/

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-zk.sh"]
