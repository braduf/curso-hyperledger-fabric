# ORG 4
export CSR_NAMES_ORG4="C=CO,ST=Antioquia,L=Medellin,O=Org4,OU=Hyperledger Fabric"
# Enroll bootstrap identity of root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/org4.acme.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:10054 --csr.names "$CSR_NAMES_ORG4"
# Register intermediate CA in the root CA
fabric-ca-client register --id.name int.ca.org4.acme.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:10054
# Enroll bootstrap identity of tls root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/org4.acme.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:10055 --csr.names "$CSR_NAMES_ORG4"
# Register intermediate CA in the tls root CA
fabric-ca-client register --id.name tls.int.ca.org4.acme.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:10055
