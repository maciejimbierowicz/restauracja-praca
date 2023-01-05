#!/bin/bash
if [[ -z ${EXEC_CMD} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

cd "${DIR}"

if [[ ${SSH_USER} == "user.name" ]]; then
  echo "change SSH_USER in build/.env file"
  exit 1
fi

if [[ ! -z ${EXEC_CMD+x} ]]; then
  mkdir -p "${DIR}/build/files/sites/default/"
  scp ${SSH_USER}@${DEV_SERVER}:${SCP_DB_PATH} "${DIR}/build/files/sites/default/"
fi

if [[ ! -z ${SCP_FILES_PATH+x} ]]; then
  mkdir -p "${DIR}./build/sites/default/"
  scp ${SSH_USER}@${DEV_SERVER}:${SCP_FILES_PATH} "${DIR}/build/files/sites/default/"
fi

if [[ ! -z ${SCP_PRIVATE_FILES_PATH+x} ]]; then
  mkdir -p "${DIR}./build/sites/default/"
  scp ${SSH_USER}@${DEV_SERVER}:${SCP_PRIVATE_FILES_PATH} "${DIR}/build/files/sites/default/"
fi