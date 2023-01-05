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
git submodule update --init --recursive
sed  "s/SETUID=1000/SETUID=${UID}/g" build/.env.dev > build/.env
#if test -f "${DIR}/scripts/download-db.sh"; then
#  ./exec.sh download-db
#fi