#!/usr/bin/env sh

set -e

getFileEnv() {
  name="$1"
  value=`printenv "$name"`
  if [ -n "$value" ]; then
    echo "$value"
  else
    name_file="${name}_FILE"
    value_file=`printenv "$name_file"`
    if [ -n "$value_file" ] && [ -f "$value_file" ]; then
      cat "$value_file"
    fi
  fi
}

ILIAS_COMMON_CLIENT_ID="${ILIAS_COMMON_CLIENT_ID:=default}"

ILIAS_CRON_USER_LOGIN="${ILIAS_CRON_USER_LOGIN:=cron}"

ILIAS_CRON_FILE="${ILIAS_CRON_FILE:=/etc/periodic/ilias}"
ILIAS_CRON_PERIOD="${ILIAS_CRON_PERIOD:=*/5 * * * *}"

if [ -f "$ILIAS_FILESYSTEM_INI_PHP_FILE" ]; then
  echo "ILIAS config found"
else
  echo "ILIAS not configured yet"
  exit 1
fi

echo "Generate cron config"
echo "$ILIAS_CRON_PERIOD $(which php) $ILIAS_WEB_DIR/cron/cron.php \"$ILIAS_CRON_USER_LOGIN\" \"$(getFileEnv ILIAS_CRON_USER_PASSWORD)\" \"$ILIAS_COMMON_CLIENT_ID\"" > "$ILIAS_CRON_FILE"
crontab -u www-data "$ILIAS_CRON_FILE"

echo "Unset ILIAS env variables (For not show in PHP variables or log files)"
for var in $(printenv | grep "ILIAS_" | sed 's/=.*$//'); do
  unset "$var"
done

echo "Start cron"
exec crond -f
