void call() {
    try {
        sh "oc patch -n user-management KeycloakRealmIdentityProvider openshift-master --type json -p \'[{\"op\": \"replace\", \"path\": \"/spec/firstBrokerLoginFlowAlias\", \"value\":\"fix-first-broker-login\"}]\'"
    } catch (any) {
        println("WARN: failed to patch KeycloakRealmIdentityProvider openshift-master")
    }
}

return this;