cd .. && docker-compose -f docker-compose-org4-root-ca.yaml -f docker-compose-org4-int-ca.yaml down
cd scripts && ./org4-cleancerts.sh
rm -r ../channel-artifacts/*.json
rm -r ../channel-artifacts/*.pb
rm -r ../fabric-ca/org4.acme.com/peers/peer0.org4.acme.com/production
rm -r ../fabric-ca/org4.acme.com/orderers/orderer.org4.acme.com/production

