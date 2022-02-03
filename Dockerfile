FROM mcr.microsoft.com/windows/nanoserver

LABEL "repository"="https://github.com/baudoliver7/etcd-windows-image"
LABEL "maintainer"="Olivier B. OURA"

ENV ETCD_VER=v3.5.1

RUN mkdir -p c:/temp/bin

RUN iwr -outf c:/temp/etcd-download-test.zip https://github.com/etcd-io/etcd/releases/download/$ETCD_VER/etcd-$ETCD_VER-windows-amd64.zip
RUN Expand-Archive -Path c:/temp/etcd-download-test.zip -DestinationPath c:/temp/bin
RUN Remove-Item -Path c:/temp/etcd-download-test.zip -Force
RUN c:/temp/bin/etcd --version
RUN c:/temp/bin/etcdctl version
RUN c:/temp/bin/etcdutl version

EXPOSE 2379 2380

# Define default command.
CMD ["c:/temp/bin/etcd"]
