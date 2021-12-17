FROM ubuntu:20.04

# These are fed in from the build script
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION

LABEL \
  org.opencontainers.image.created="${BUILD_DATE}" \
  org.opencontainers.image.description="A Pop!_Shop compatible api server" \
  org.opencontainers.image.revision="${VCS_REF}" \
  org.opencontainers.image.source="https://github.com/pop-os/warehouse" \
  org.opencontainers.image.title="deckard" \
  org.opencontainers.image.vendor="system76" \
  org.opencontainers.image.version="${VERSION}"

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
