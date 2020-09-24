function cleanCA(){
    org=$1
    ca=$2

    CA_PATH=../fabric-ca/$org/$ca
    sudo rm -r $CA_PATH/clients
    sudo rm -r $CA_PATH/msp
    sudo rm $CA_PATH/ca-cert.pem
    sudo rm $CA_PATH/fabric-ca-server.db
    sudo rm $CA_PATH/IssuerPublicKey
    sudo rm $CA_PATH/IssuerRevocationPublicKey
    CA_CHAIN_FILE=$CA_PATH/ca-chain.pem
    if test -f "$CA_CHAIN_FILE"; then
        sudo rm $CA_CHAIN_FILE
    fi
}

function cleanOrgMSP() {
    org=$1

    MSP_PATH=../fabric-ca/$org/msp
    sudo rm -r $MSP_PATH/cacerts
    sudo rm -r $MSP_PATH/intermediatecerts
    sudo rm -r $MSP_PATH/tlscacerts
    sudo rm -r $MSP_PATH/tlsintermediatecerts
}

function cleanLocalMSP() {
    org=$1
    name=$2
    type=$3

    LOCAL_MSP_PATH=../fabric-ca/$org/${type}s/$name/msp
    TLS_FOLDER_PATH=../fabric-ca/$org/${type}s/$name/tls

    sudo rm -r $LOCAL_MSP_PATH
    sudo rm -r $TLS_FOLDER_PATH
}


cleanCA org4.acme.com root
cleanCA org4.acme.com int
cleanCA org4.acme.com tls-root
cleanCA org4.acme.com tls-int

cleanOrgMSP org4.acme.com

cleanLocalMSP org4.acme.com orderer.org4.acme.com orderer

cleanLocalMSP org4.acme.com peer0.org4.acme.com peer

cleanLocalMSP org4.acme.com admin@org4.acme.com user

cleanLocalMSP org4.acme.com client@org4.acme.com user
