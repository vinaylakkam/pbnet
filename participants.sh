# Add participants

composer card delete -c alice@pbnet
composer card delete -c bob@pbnet

rm alice_exp.card
rm bob_exp.card

composer participant add -c admin@pbnet -d '{"$class":"org.uspc.pbnet.Payer","payerKey":"alice", "name":"alice", "address":"US","email":"alice@uhg-test.com"}'
composer participant add -c admin@pbnet -d '{"$class":"org.uspc.pbnet.Payer","payerKey":"bob", "name":"bob", "address":"US","email":"bob@cigna-test.com"}'

composer identity issue -c admin@pbnet -f alice.card -u alice -a "resource:org.uspc.pbnet.Payer#alice"
composer identity issue -c admin@pbnet -f bob.card -u bob -a "resource:org.uspc.pbnet.Payer#bob"

composer card import -f alice.card
composer card import -f bob.card

sed \
-e 's/localhost:7051/peer0.org1.example.com:7051/' \
-e 's/localhost:8051/peer1.org1.example.com:8051/' \
-e 's/localhost:7053/peer0.org1.example.com:7053/' \
-e 's/localhost:8053/peer1.org1.example.com:8053/' \
-e 's/localhost:7054/ca.org1.example.com:7054/'  \
-e 's/localhost:7050/orderer.example.com:7050/'  \
< $HOME/.composer/cards/alice@pbnet/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/alice@pbnet/ 

sed \
-e 's/localhost:7051/peer0.org1.example.com:7051/' \
-e 's/localhost:8051/peer1.org1.example.com:8051/' \
-e 's/localhost:7053/peer0.org1.example.com:7053/' \
-e 's/localhost:8053/peer1.org1.example.com:8053/' \
-e 's/localhost:7054/ca.org1.example.com:7054/'  \
-e 's/localhost:7050/orderer.example.com:7050/'  \
< $HOME/.composer/cards/bob@pbnet/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/bob@pbnet/ 


composer card export -f alice_exp.card -c alice@pbnet ; rm alice.card
composer card export -f bob_exp.card -c bob@pbnet ; rm bob.card

composer card list


