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

# Org1
export CSR_NAMES_ORG1="C=CO,ST=Antioquia,L=Medellin,O=Org1,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 7056 org1.acme.org admin@org1.acme.org adminpw admin "$CSR_NAMES_ORG1" ""
# issue certificates for client identity and for client tls
issueCertificates int 7056 org1.acme.org client@org1.acme.org clientpw client "$CSR_NAMES_ORG1" ""
issueCertificates tls-int 7057 org1.acme.org client@org1.acme.org clientpw client "$CSR_NAMES_ORG1" "client@org1.acme.org,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 7056 org1.acme.org peer0.org1.acme.org peerpw peer "$CSR_NAMES_ORG1" ""
issueCertificates tls-int 7057 org1.acme.org peer0.org1.acme.org peerpw peer "$CSR_NAMES_ORG1" "peer0.org1.acme.org,localhost"

# Org2
export CSR_NAMES_ORG2="C=CL,ST=Santiago,L=Santiago,O=Org2,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 8056 org2.acme.org admin@org2.acme.org adminpw admin "$CSR_NAMES_ORG2" ""
# issue certificates for client identity and for client tls
issueCertificates int 8056 org2.acme.org client@org2.acme.org clientpw client "$CSR_NAMES_ORG2" ""
issueCertificates tls-int 8057 org2.acme.org client@org2.acme.org clientpw client "$CSR_NAMES_ORG2" "client@org2.acme.org,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 8056 org2.acme.org peer0.org2.acme.org peerpw peer "$CSR_NAMES_ORG2" ""
issueCertificates tls-int 8057 org2.acme.org peer0.org2.acme.org peerpw peer "$CSR_NAMES_ORG2" "peer0.org2.acme.org,localhost"

# Org3
export CSR_NAMES_ORG3="C=MX,ST=Mexico City,L=Mexico City,O=Org3,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 9056 org3.acme.org admin@org3.acme.org adminpw admin "$CSR_NAMES_ORG3" ""
# issue certificates for client identity and for client tls
issueCertificates int 9056 org3.acme.org client@org3.acme.org clientpw client "$CSR_NAMES_ORG3" ""
issueCertificates tls-int 9057 org3.acme.org client@org3.acme.org clientpw client "$CSR_NAMES_ORG3" "client@org3.acme.org,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 9056 org3.acme.org peer0.org3.acme.org peerpw peer "$CSR_NAMES_ORG3"
issueCertificates tls-int 9057 org3.acme.org peer0.org3.acme.org peerpw peer "$CSR_NAMES_ORG3" "peer0.org3.acme.org,localhost"

# Acme
export CSR_NAMES_ACME="C=BE,ST=Flemish Brabant,L=Louvain,O=Acme,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 10056 acme.org admin@acme.org adminpw admin "$CSR_NAMES_ACME" ""
# issue certificates for client tls
issueCertificates tls-int 10057 acme.org client@acme.org clientpw client "$CSR_NAMES_ACME" "client@acme.org,localhost"
# issue certificates for orderer node identity and for orderer server tls
issueCertificates int 10056 acme.org orderer.acme.org ordererpw orderer "$CSR_NAMES_ACME" ""
issueCertificates tls-int 10057 acme.org orderer.acme.org ordererpw orderer "$CSR_NAMES_ACME" "orderer.acme.org,localhost"