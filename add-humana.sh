# Add Humana

composer card delete -c HumanaAdmin@pbnet

rm HumanaAdmin_exp.card

composer participant add -c admin@pbnet -d '{"$class":"org.uspc.pbnet.Payer","payerKey":"HUMANA", "name":"United Health Group", "address":"US","email":"admin@humana-test.com"}'

composer identity issue -c admin@pbnet -f HumanaAdmin.card -u HumanaAdmin -a "resource:org.uspc.pbnet.Payer#HUMANA"

composer card import -f HumanaAdmin.card


sed \
-e 's/localhost:7051/peer0.org1.example.com:7051/' \
-e 's/localhost:8051/peer1.org1.example.com:8051/' \
-e 's/localhost:7053/peer0.org1.example.com:7053/' \
-e 's/localhost:8053/peer1.org1.example.com:8053/' \
-e 's/localhost:7054/ca.org1.example.com:7054/'  \
-e 's/localhost:7050/orderer.example.com:7050/'  \
< $HOME/.composer/cards/HumanaAdmin@pbnet/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/HumanaAdmin@pbnet/ 

composer card export -f HumanaAdmin_exp.card -c HumanaAdmin@pbnet ; rm HumanaAdmin.card

composer card list


