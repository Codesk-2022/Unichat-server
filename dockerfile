FROM ubuntu:20.04

FROM ubuntu:20.04

# set nodejs version
ENV node_version="16.13.1"

# install nodejs
RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
  amd64) ARCH='x64';; \
  ppc64el) ARCH='ppc64le';; \
  s390x) ARCH='s390x';; \
  arm64) ARCH='arm64';; \
  armhf) ARCH='armv7l';; \
  i386) ARCH='x86';; \
  *) echo "unsupported architecture"; exit 1 ;; \
  esac && \
  apt update && \
  apt install -y xz-utils && \
  apt install -y wget && \
  wget https://nodejs.org/dist/v$node_version/node-v$node_version-linux-$ARCH.tar.xz && \
  tar -xf node-v$node_version-linux-$ARCH.tar.xz && \
  mv node-v${node_version}-linux-${ARCH}/ /opt/node && \
  rm -rf node-v${node_version}-linux-${ARCH}.tar.gz

ENV PATH="$PATH:/opt/node/bin"

# install nginx
RUN apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring && \
  mkdir ~/.gnupg && \
  curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
  | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null && \
  gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
  | tee /etc/apt/sources.list.d/nginx.list && \
  apt update && \
  apt install -y nginx

# configure nginx
WORKDIR /etc/nginx/conf.d/
COPY ./nginx/conf/*.conf ./ 

# configure frontend
WORKDIR /usr/share/nginx/html

# configure APIserver
WORKDIR /usr/src/app/
COPY package*.json ./
COPY tsconfig.json ./
RUN npm i
COPY ./src ./src
RUN npm run build

CMD service nginx start \
&&  npm run start