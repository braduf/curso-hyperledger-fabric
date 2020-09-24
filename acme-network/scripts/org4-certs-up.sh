cd .. && docker-compose -f docker-compose-org4-root-ca.yaml up -d
sleep 5
cd scripts && ./org4-rootca.sh
cd .. && docker-compose -f docker-compose-org4-int-ca.yaml up -d
sleep 5
cd scripts && ./org4-intca.sh
./org4-identities.sh
./org4-msp.sh
