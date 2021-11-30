ARG ILIAS_BASE_IMAGE=docker-registry.fluxpublisher.ch/flux-ilias/ilias-base:php8.0

FROM $ILIAS_BASE_IMAGE

LABEL org.opencontainers.image.source="https://github.com/fluxapps/flux-ilias-cron-base"

COPY . /flux-ilias-cron-base

ENTRYPOINT ["/flux-ilias-cron-base/bin/entrypoint.sh"]

ENV ILIAS_CRON_FILE /etc/periodic/ilias
ENV ILIAS_CRON_PERIOD */5 * * * *
