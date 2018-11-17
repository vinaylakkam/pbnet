# Add participants

composer card delete -c AetnaAdmin@pbnet
composer card delete -c CignaAdmin@pbnet

rm AetnaAdmin_exp.card
rm CignaAdmin_exp.card

composer participant add -c admin@pbnet -d '{"$class":"org.uspc.pbnet.Payer","payerKey":"AETNA", "name":"AETNA", "address":"US","email":"admin@aetna-test.com"}'
composer participant add -c admin@pbnet -d '{"$class":"org.uspc.pbnet.Payer","payerKey":"CIGNA", "name":"CIGNA", "address":"US","email":"admin@cigna-test.com"}'

composer identity issue -c admin@pbnet -f AetnaAdmin.card -u AetnaAdmin -a "resource:org.uspc.pbnet.Payer#AETNA"
composer identity issue -c admin@pbnet -f CignaAdmin.card -u CignaAdmin -a "resource:org.uspc.pbnet.Payer#CIGNA"

composer card import -f AetnaAdmin.card
composer card import -f CignaAdmin.card


sed \
-e 's/localhost:7051/peer0.org1.example.com:7051/' \
-e 's/localhost:8051/peer1.org1.example.com:8051/' \
-e 's/localhost:7053/peer0.org1.example.com:7053/' \
-e 's/localhost:8053/peer1.org1.example.com:8053/' \
-e 's/localhost:7054/ca.org1.example.com:7054/'  \
-e 's/localhost:7050/orderer.example.com:7050/'  \
< $HOME/.composer/cards/AetnaAdmin@pbnet/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/AetnaAdmin@pbnet/ 

sed \
-e 's/localhost:7051/peer0.org1.example.com:7051/' \
-e 's/localhost:8051/peer1.org1.example.com:8051/' \
-e 's/localhost:7053/peer0.org1.example.com:7053/' \
-e 's/localhost:8053/peer1.org1.example.com:8053/' \
-e 's/localhost:7054/ca.org1.example.com:7054/'  \
-e 's/localhost:7050/orderer.example.com:7050/'  \
< $HOME/.composer/cards/CignaAdmin@pbnet/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/CignaAdmin@pbnet/ 


composer card export -f AetnaAdmin_exp.card -c AetnaAdmin@pbnet ; rm AetnaAdmin.card
composer card export -f CignaAdmin_exp.card -c CignaAdmin@pbnet ; rm CignaAdmin.card

composer card list


