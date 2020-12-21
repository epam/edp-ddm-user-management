#!/bin/bash

oc get secret keycloak --namespace=$1 -o json | \
  jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid,.metadata.managedFields,.metadata.selfLink,.metadata.ownerReferences) | .metadata.creationTimestamp=null' | \
  oc apply --namespace=$2 -f -