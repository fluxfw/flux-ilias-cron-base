ARG FLUX_ILIAS_BASE_IMAGE=docker-registry.fluxpublisher.ch/flux-ilias/ilias-base:php8.0

FROM $FLUX_ILIAS_BASE_IMAGE

LABEL org.opencontainers.image.source="https://github.com/flux-caps/flux-ilias-cron-base"

ENTRYPOINT ["/flux-ilias-cron-base/bin/docker-entrypoint.sh"]

COPY . /flux-ilias-cron-base
