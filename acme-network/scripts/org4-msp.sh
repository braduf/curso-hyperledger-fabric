function createChannelMSP() {
    org=$1

    MSP_PATH=../fabric-ca/$org/msp
    mkdir -p $MSP_PATH
    mkdir $MSP_PATH/cacerts && cp ../fabric-ca/$org/root/ca-cert.pem $MSP_PATH/cacerts/ca-cert.pem
    mkdir $MSP_PATH/intermediatecerts && cp ../fabric-ca/$org/int/ca-cert.pem $MSP_PATH/intermediatecerts/ca-cert.pem
    mkdir $MSP_PATH/tlscacerts && cp ../fabric-ca/$org/tls-root/ca-cert.pem $MSP_PATH/tlscacerts/ca-cert.pem
    mkdir $MSP_PATH/tlsintermediatecerts && cp ../fabric-ca/$org/tls-int/ca-cert.pem $MSP_PATH/tlsintermediatecerts/ca-cert.pem
}

function createLocalMSP() {
    org=$1
    name=$2
    type=$3

    LOCAL_MSP_PATH=../fabric-ca/$org/${type}s/$name/msp

    mkdir -p $LOCAL_MSP_PATH
    cp ../fabric-ca/$org/msp/config.yaml $LOCAL_MSP_PATH
    mkdir $LOCAL_MSP_PATH/cacerts && cp ../fabric-ca/$org/root/ca-cert.pem $LOCAL_MSP_PATH/cacerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/intermediatecerts && cp ../fabric-ca/$org/int/ca-cert.pem $LOCAL_MSP_PATH/intermediatecerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/tlscacerts && cp ../fabric-ca/$org/tls-root/ca-cert.pem $LOCAL_MSP_PATH/tlscacerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/tlsintermediatecerts && cp ../fabric-ca/$org/tls-int/ca-cert.pem $LOCAL_MSP_PATH/tlsintermediatecerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/signcerts && cp -r ../fabric-ca/$org/int/clients/$name/msp/signcerts $LOCAL_MSP_PATH/
    key=$(find ../fabric-ca/$org/int/clients/$name/msp/keystore -name *_sk)
    mkdir $LOCAL_MSP_PATH/keystore && cp $key $LOCAL_MSP_PATH/keystore/priv.key
}

function createTLSFolder(){
    org=$1
    name=$2
    type=$3

    TLS_FOLDER_PATH=../fabric-ca/$org/${type}s/$name/tls

    mkdir -p $TLS_FOLDER_PATH
    cp ../fabric-ca/$org/tls-int/ca-chain.pem $TLS_FOLDER_PATH/ca.crt
    cp ../fabric-ca/$org/tls-int/clients/$name/msp/signcerts/cert.pem $TLS_FOLDER_PATH/server.crt
    key=$(find ../fabric-ca/$org/tls-int/clients/$name/msp/keystore -name *_sk)
    cp $key $TLS_FOLDER_PATH/server.key
}

createChannelMSP org4.acme.com

createLocalMSP org4.acme.com peer0.org4.acme.com peer
createTLSFolder org4.acme.com peer0.org4.acme.com peer

createLocalMSP org4.acme.com orderer.org4.acme.com orderer
createTLSFolder org4.acme.com orderer.org4.acme.com orderer

createLocalMSP org4.acme.com admin@org4.acme.com user
createTLSFolder org4.acme.com admin@org4.acme.com user

createLocalMSP org4.acme.com client@org4.acme.com user
createTLSFolder org4.acme.com client@org4.acme.com user
