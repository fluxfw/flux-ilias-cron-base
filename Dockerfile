ARG FLUX_ILIAS_BASE_IMAGE=fluxfw/flux-ilias-ilias-base
ARG PHP_VERSION
FROM $FLUX_ILIAS_BASE_IMAGE:php$PHP_VERSION

ENTRYPOINT ["/flux-ilias-cron-base/bin/docker-entrypoint.sh"]

COPY . /flux-ilias-cron-base

ARG COMMIT_SHA
LABEL org.opencontainers.image.revision="$COMMIT_SHA"
