#!/bin/bash -e
sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' $SERVICE_HOME/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' $SERVICE_HOME/conf/zoo.cfg

echo "" >> "$SERVICE_CONF"

for VAR in $(env)
do
  if [[ $VAR =~ ^ZK_ && ! $VAR =~ ^ZK_HOME ]]; then
    kafka_name=$(echo "$VAR" | sed -r 's/ZK_(.*)=.*/\1/g' | tr _ .)
    env_var=$(echo "$VAR" | sed -r 's/(.*)=.*/\1/g')
    if grep -E -q '(^|^#)'"$kafka_name=" "$SERVICE_CONF"; then
        sed -r -i 's@(^|^#)('"$kafka_name"')=(.*)@\2='"${!env_var}"'@g' "$SERVICE_CONF" #note that no config values may contain an '@' char
    else
        echo "$kafka_name=${!env_var}" >> "$SERVICE_CONF"
    fi
  fi
done

if [[ -n "$CUSTOM_INIT_SCRIPT" ]] ; then
  eval "$CUSTOM_INIT_SCRIPT"
fi

exec "${SERVICE_HOME}/bin/zkServer.sh" "start-foreground"
