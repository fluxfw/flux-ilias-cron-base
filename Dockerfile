ARG FLUX_ILIAS_BASE_IMAGE=docker-registry.fluxpublisher.ch/flux-ilias/ilias-base
ARG PHP_VERSION

FROM alpine:latest AS build

COPY . /build/flux-ilias-cron-base

RUN (cd /build && tar -czf flux-ilias-cron-base.tar.gz flux-ilias-cron-base)

FROM $FLUX_ILIAS_BASE_IMAGE:php$PHP_VERSION

LABEL org.opencontainers.image.source="https://github.com/flux-caps/flux-ilias-cron-base"

ENTRYPOINT ["/flux-ilias-cron-base/bin/docker-entrypoint.sh"]

COPY --from=build /build /

ARG COMMIT_SHA
LABEL org.opencontainers.image.revision="$COMMIT_SHA"
