FROM adoptopenjdk/openjdk11:alpine

# install the powershell
RUN apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    dos2unix \
    git \
    bash \
    icu-libs \
    curl &&\
apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust &&\
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/powershell-7.1.3-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz &&\
mkdir -p /opt/microsoft/powershell/7 &&\
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 &&\
chmod +x /opt/microsoft/powershell/7/pwsh &&\
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh &&\
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/powershell

# clone e6
RUN mkdir -p /opt/minecraft &&\
 cd /opt/minecraft &&\
 git clone https://github.com/NillerMedDild/Enigmatica6.git /opt/minecraft
WORKDIR /opt/minecraft

# setup e6
RUN git checkout 0.4.14 &&\
    cd automation &&\
    dos2unix *.sh &&\
    pwsh update-server.ps1 0.4.14 &&\
    cd .. &&\
    java -jar InstanceSync.jar &&\
    echo 'eula=true'>eula.txt

COPY docker-entrypoint.sh /opt/minecraft
ENTRYPOINT ["/opt/minecraft/docker-entrypoint.sh"]
CMD ["minecraft"]
