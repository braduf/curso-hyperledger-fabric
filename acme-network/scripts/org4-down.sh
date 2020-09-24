cd .. && docker-compose -f docker-compose-org4-orderer-peer-couchdb.yaml down
rm -r ../channel-artifacts/*.json
rm -r ../channel-artifacts/*.pb
rm -r ../fabric-ca/org4.acme.com/peers/peer0.org4.acme.com/production
rm -r ../fabric-ca/org4.acme.com/orderers/orderer.org4.acme.com/production
