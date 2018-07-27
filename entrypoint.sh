#!/bin/bash
set -eux

if [ ! -e /var/www/html/index.php ];  then

    PUID=${PUID:=15000}
    PUSER=${PUSER:=mediadepot}
    PGID=${PGID:=15000}
    PGROUP=${PGROUP:=mediadepot}

    #Create internal mediadepot user (which will be mapped to external user and used to run the process)
    addgroup --system --gid $PGID $PGROUP  && adduser --system --disabled-password --uid $PUID --gid $PGID --shell /bin/bash $PUSER

	echo "[FileRun fresh install]"
	unzip /filerun.zip -d /var/www/html/
	cp /autoconfig.php /var/www/html/system/data/
	chown -R ${PUSER}:${PGROUP} /var/www/html
	# chown -R ${PUSER}:${PGROUP} /user-files
	mysql_host="${FR_DB_HOST:-mysql}"
    mysql_port="${FR_DB_PORT:-3306}"
	/wait-for-it.sh $mysql_host:$mysql_port -t 120 -- /import-db.sh

fi

exec "$@"