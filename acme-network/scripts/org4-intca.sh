# ORG 4
export CSR_NAMES_ORG4="C=CO,ST=Antioquia,L=Medellin,O=Org4,OU=Hyperledger Fabric"
# Enroll bootstrap identity of int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/org4.acme.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:10056 --csr.names "$CSR_NAMES_ORG4"
# Enroll bootstrap identity of tls int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/org4.acme.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:10057 --csr.names "$CSR_NAMES_ORG4"
