void call() {
    String identityProviderName = "id-gov-ua"
    String namespace = "user-management"
    try {
        sh "oc delete KeycloakRealmIdentityProvider $identityProviderName -n ${namespace} --ignore-not-found=true"
    } catch (any) {
        println("WARN: failed to delete unused KeycloakRealmIdentityProvider ${identityProviderName}")
    }
}

return this;