# Channel update commands

```shell
export FABRIC_CFG_PATH=$PWD && configtxgen -profile Peikiuar -channelID peikiuar -outputBlock new_config_block.pb

configtxlator proto_decode --input new_config_block.pb --type common.Block --output new_config.json | sudo jq .data.data[0].payload.data.config new_config.json > new_config.json

configtxlator proto_decode --input config_block.pb --type common.Block --output config.json | sudo jq .data.data[0].payload.data.config config.json > config.json

configtxlator proto_encode --input new_config.json --type common.Config --output new_config.pb

configtxlator proto_encode --input config.json --type common.Config --output config.pb

configtxlator compute_update --channel_id peikiuar --original config.pb --updated new_config.pb --output update.pb

configtxlator proto_decode --input update.pb --type common.ConfigUpdate --output update.json | sudo jq . update.json > update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"peikiuar", "type":2}},"data":{"config_update":'$(cat update.json)'}}}' | jq . > update_in_envelope.json

configtxlator proto_encode --input update_in_envelope.json --type common.Envelope --output update_in_envelope.pb
```
