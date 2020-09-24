# Org4 Channel update commands: part 1

## Create and add msp of Org4

## Update configtx.yaml

Org4 to organizations without ordererEndpoints
Add consenter to raft cluster
Add to system channel orgs
Add to consortium orgs

```shell
cd .. && export FABRIC_CFG_PATH=$PWD
export CORE_PEER_MSPCONFIGPATH=$(echo $PWD/fabric-ca/org1.acme.com/users/admin@org1.acme.com/msp)
export CLIENTAUTH_CERTFILE=$(echo $PWD/fabric-ca/org1.acme.com/users/admin@org1.acme.com/tls/server.crt)
export CLIENTAUTH_KEYFILE=$(echo $PWD/fabric-ca/org1.acme.com/users/admin@org1.acme.com/tls/server.key)
export CORE_PEER_LOCALMSPID=Org1MSP
export ORDERER_CA=$(echo $PWD/fabric-ca/org1.acme.com/orderers/orderer.org1.acme.com/tls/ca.crt)
export ORDERER_ADDRESS=localhost:7050

# Fetch the latest (actual) config block of the network
peer channel fetch config channel-artifacts/config_block.pb -o $ORDERER_ADDRESS -c system-channel --tls --cafile $ORDERER_CA --clientauth --certfile $CLIENTAUTH_CERTFILE --keyfile $CLIENTAUTH_KEYFILE
# Convert the actual config block to json
configtxlator proto_decode --input channel-artifacts/config_block.pb --type common.Block --output channel-artifacts/config_block.json && jq .data.data[0].payload.data.config channel-artifacts/config_block.json > channel-artifacts/config.json
# Convert the actual config block to a config update block
configtxlator proto_encode --input channel-artifacts/config.json --type common.Config --output channel-artifacts/config.pb

# Create the new desired config block
configtxgen -profile ThreeOrgsOrdererGenesis -channelID system-channel -outputBlock channel-artifacts/new_config_block.pb
# Convert the new config block to json
configtxlator proto_decode --input channel-artifacts/new_config_block.pb --type common.Block --output channel-artifacts/new_config_block.json && jq .data.data[0].payload.data.config channel-artifacts/new_config_block.json > channel-artifacts/new_config.json
# Convert the new config block to a config update block
configtxlator proto_encode --input channel-artifacts/new_config.json --type common.Config --output channel-artifacts/new_config.pb

# Calculate the diference between the existing config and the desired config
configtxlator compute_update --channel_id system-channel --original channel-artifacts/config.pb --updated channel-artifacts/new_config.pb --output channel-artifacts/update.pb
# Convert the update again to an editable json file
configtxlator proto_decode --input channel-artifacts/update.pb --type common.ConfigUpdate --output channel-artifacts/temp_update.json && jq . channel-artifacts/temp_update.json > channel-artifacts/update.json
# Add the header envelope again
echo '{"payload":{"header":{"channel_header":{"channel_id":"system-channel", "type":2}},"data":{"config_update":'$(cat channel-artifacts/update.json)'}}}' | jq . > channel-artifacts/update_in_envelope.json
# Convert it again to the complete protobuffer file that Fabric expects
configtxlator proto_encode --input channel-artifacts/update_in_envelope.json --type common.Envelope --output channel-artifacts/update_in_envelope.pb

# Sign the update and pass it to the other organizations to sign again so a majority of organizations approve the inclusion of Org4
peer channel signconfigtx -f channel-artifacts/update_in_envelope.pb

# Change to Org2 to sign it (majority vote) and update the network
export CORE_PEER_MSPCONFIGPATH=$(echo $PWD/fabric-ca/org2.acme.com/users/admin@org2.acme.com/msp)
export CLIENTAUTH_CERTFILE=$(echo $PWD/fabric-ca/org2.acme.com/users/admin@org2.acme.com/tls/server.crt)
export CLIENTAUTH_KEYFILE=$(echo $PWD/fabric-ca/org2.acme.com/users/admin@org2.acme.com/tls/server.key)
export CORE_PEER_LOCALMSPID=Org2MSP
peer channel update -f channel-artifacts/update_in_envelope.pb -c system-channel -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA --clientauth --certfile $CLIENTAUTH_CERTFILE --keyfile $CLIENTAUTH_KEYFILE
```
