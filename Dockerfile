FROM docker.io/alpine

LABEL maintainer="Lukas Steiner <lukas.steiner@siticom.de>"

RUN apk add --no-cache inotify-tools bash

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
