FROM ubuntu:20.04

ENV LANG=C.UTF-8 \
  TERM=xterm \
  SHELL=/bin/bash

RUN apt-get update && \
  apt-get install -y \
  bash \
  openssl \
  libsctp1 \
  libodbc1

WORKDIR /opt/app

ARG mix_env=prod

ENV APP_NAME=deckard \
  MIX_ENV=${mix_env}

COPY --chown=root:root ./_build/${mix_env}/rel/${APP_NAME}/ ./

EXPOSE 4000

ENTRYPOINT ["bin/deckard"]
CMD ["start"]
