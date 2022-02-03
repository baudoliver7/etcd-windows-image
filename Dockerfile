FROM mcr.microsoft.com/windows/nanoserver:1809

LABEL "repository"="https://github.com/baudoliver7/etcd-windows-image"
LABEL "maintainer"="Olivier B. OURA"

ENV ETCD_VER=v3.5.1

RUN mkdir c:\temp
RUN mkdir c:\temp\bin
RUN dir
RUN curl --silent -o c:\temp\unzip.exe https://www.7-zip.org/a/7z2107.exe
RUN curl --silent -o c:\temp\etcd-download-test.zip https://github.com/etcd-io/etcd/releases/download/$ETCD_VER/etcd-$ETCD_VER-windows-amd64.zip
RUN dir
RUN c:\temp\unzip.exe --help
RUN tar -xvf c:\temp\etcd-download-test.zip
RUN dir
RUN dir c:\temp\bin
RUN del c:\temp\etcd-download-test.zip -Force
RUN c:\temp\bin\etcd --version
RUN c:\temp\bin\etcdctl version
RUN c:\temp\bin\etcdutl version

EXPOSE 2379 2380

# Define default command.
CMD ["c:\temp\bin\etcd"]
