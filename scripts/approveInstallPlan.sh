#!/usr/bin/env bash

export GLOBAL_EDP_PROJECT=$1
export GROUP_SYNC_OPERATOR_VERSION=$2
export GROUP_SYNC_OPERATOR_NAME="group-sync-operator.v${GROUP_SYNC_OPERATOR_VERSION}"
export NAMESPACE=$3

if [ ${GLOBAL_EDP_PROJECT} == "control-plane" ]; then
  sleep 10
  export INSTALL_PLAN=$(oc get installplan -n ${NAMESPACE} -o=jsonpath="{.items[?(@.spec.clusterServiceVersionNames[0]=='${GROUP_SYNC_OPERATOR_NAME}')].metadata.name}")
  if [[ ${INSTALL_PLAN} == '' ]]; then
    echo "Nothing to approve"
  else
    for IP in ${INSTALL_PLAN}
    do
      if ! $(oc get installplan -n ${NAMESPACE} ${IP} -o=jsonpath='{.spec.approved}'); then
        echo "Approved ${IP}"
        oc patch installplan ${IP} -n ${NAMESPACE} --type merge --patch '{"spec":{"approved":true}}'
      fi
    done
    sleep 10
  fi
else
  echo "Approve install plan skipped"
fi
