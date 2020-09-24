function issueCertificates() {
    ca=$1
    ca_port=$2
    org=$3
    id_name=$4
    id_secret=$5
    id_type=$6
    csr_names=$7
    csr_hosts=$8


    # register identity with CA admin
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/admin
    fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type -u http://admin:adminpw@localhost:$ca_port
    # enroll registered identity
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/$id_name
    fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts"
}

function issueCertificatesWithAffiliation() {
    ca=$1
    ca_port=$2
    org=$3
    id_name=$4
    id_secret=$5
    id_type=$6
    id_affiliation=$7
    csr_names=$8
    csr_hosts=$9


    # register identity with CA admin
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/admin
    fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type --id.affiliation $id_affiliation -u http://admin:adminpw@localhost:$ca_port
    # enroll registered identity
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/$id_name
    fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts"
}

function issueTLSCertificates() {
    ca=$1
    ca_port=$2
    org=$3
    id_name=$4
    id_secret=$5
    id_type=$6
    csr_names=$7
    csr_hosts=$8


    # register identity with CA admin
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/admin
    fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type -u http://admin:adminpw@localhost:$ca_port
    # enroll registered identity
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/$id_name
    fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts" --enrollment.profile tls
}

# Org4
export CSR_NAMES_ORG4="C=CO,ST=Antioquia,L=Medellin,O=Org4,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 10056 org4.acme.com admin@org4.acme.com adminpw admin "$CSR_NAMES_ORG4" ""
issueTLSCertificates tls-int 10057 org4.acme.com admin@org4.acme.com adminpw admin "$CSR_NAMES_ORG4" "admin@org4.acme.com,localhost"
# issue certificates for client identity and for client tls
issueCertificatesWithAffiliation int 10056 org4.acme.com client@org4.acme.com clientpw client marketplace "$CSR_NAMES_ORG4" ""
issueTLSCertificates tls-int 10057 org4.acme.com client@org4.acme.com clientpw client "$CSR_NAMES_ORG4" "client@org4.acme.com,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 10056 org4.acme.com peer0.org4.acme.com peerpw peer "$CSR_NAMES_ORG4" ""
issueTLSCertificates tls-int 10057 org4.acme.com peer0.org4.acme.com peerpw peer "$CSR_NAMES_ORG4" "peer0.org4.acme.com,localhost"
# issue certificates for orderer node identity and for orderer server tls
issueCertificates int 10056 org4.acme.com orderer.org4.acme.com ordererpw orderer "$CSR_NAMES_ORG4" ""
issueTLSCertificates tls-int 10057 org4.acme.com orderer.org4.acme.com ordererpw orderer "$CSR_NAMES_ORG4" "orderer.org4.acme.com,localhost"
