#!/bin/bash
if [[ -z ${EXEC_CMD} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

#echo "${BASE_CMD_RUN}"
cd "${DIR}"
sed  "s/SETUID=1000/SETUID=${UID}/g" build/.env.dev > build/.env

if [[ -f "$DIR/build/.env" ]]; then
    # Load all variables from .env and export them all for script to read
    set -o allexport
    source "$DIR/build/.env"
    set +o allexport
else
  echo "Something gone wrong. Exiting..."
  exit 1
fi

SITE_NAME=`echo $DOMAIN | tr "." "-"`
BUILD_NAME=${SITE_NAME}-`echo ${JOB_BASE_NAME} | awk '{print tolower($0)}'`
HOST_NAME=${BUILD_NAME}.$(cat /etc/hostname)
echo ${HOST_NAME}

echo "" >> build/.env
echo "COMPOSE_PROJECT_NAME=${BUILD_NAME}" >> build/.env
echo "D_HOST=${HOST_NAME}" >> build/.env
echo "D_HOST_ADDITIONAL=,www.${HOST_NAME}" >> build/.env

COMPOSE_PROJECT_NAME=${BUILD_NAME}
D_HOST=${HOST_NAME}
D_HOST_ADDITIONAL=,www.${HOST_NAME}

mkdir -p "${DIR}/build/files/sites/default/"
cp /opt/internal/${DOMAIN}/database.sql.gz "${DIR}/build/files/sites/default/database.sql.gz"
#cp /opt/internal/${DOMAIN}/files.tar.gz "${DIR}/build//files/sites/default/files.tar.gz"
#cp /opt/internal/${DOMAIN}/private-files.tar.gz "${DIR}/build//files/sites/default/private-files.tar.gz"

./exec.sh down
./exec.sh pull
./exec.sh build
./exec.sh up -d --force-recreate --remove-orphans
./exec.sh build-site


sudo chmod -R +w "${WORKSPACE}"
sudo chown -R dropadmin:dropadmin "${WORKSPACE}"