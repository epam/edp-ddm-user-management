#!/usr/bin/env bash

export RESOURCE_TYPE=$1
export RESOURCE=$2
export NAMESPACE=$3

if [[ ${NAMESPACE} == '' && ${RESOURCE} == '' && ${RESOURCE_TYPE} == '' ]]; then
  echo "Variables are not defined, exiting"
  exit 1
fi

echo "Checking '${RESOURCE}' of type '${RESOURCE_TYPE}' in '${NAMESPACE}'"
while [[ `oc get ${RESOURCE_TYPE} -n ${NAMESPACE} --no-headers --output=custom-columns=NAME:.metadata.name | grep ${RESOURCE}` == '' ]]; do
  echo "${RESOURCE_TYPE} '${RESOURCE}' in namespace '${NAMESPACE}' not exists, sleeping for 5 sec"
  sleep 5
done

