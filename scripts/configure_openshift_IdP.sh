#!/bin/bash

while [[ `oc get secret -n user-management keycloak-client-web-console-keycloak-client-secret --no-headers --output=custom-columns=NAME:.metadata.name` == '' ]]; do
  echo "Can't find secret keycloak-client-web-console-keycloak-client-secret, sleeping for 5 sec"
  sleep 5
done


oc get secret keycloak-client-web-console-keycloak-client-secret -n user-management -o json | \
  jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid,.metadata.managedFields,.metadata.selfLink,.metadata.ownerReferences) | .metadata.creationTimestamp=null' | \
  oc replace -n openshift-config --force -f -

sed -i "s#\[KEYCLOAK_URL\]#$1#" ../scripts/cluster.yaml

oc apply -f ../scripts/cluster.yaml
