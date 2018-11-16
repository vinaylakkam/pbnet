cd ~/bc/pbn-single-org

docker stop mongo
docker rm mongo

docker stop rest
docker rm rest

#mongo
docker run -d --name mongo --network composer_default -p 27017:27017 mongo

cd ~/dockertmp
docker build -t myorg/composer-rest-server .


cd ~/bc/pbn-single-org

source envvars.txt

echo $COMPOSER_CARD
echo $COMPOSER_PROVIDERS



##############################################################


#restadmin

rm -fr ~/.composer/cards/restadmin@pbn
composer card delete -c restadmin@pbn


composer participant add -c admin@pbn -d '{"$class":"org.hyperledger.composer.system.NetworkAdmin", "participantId":"restadmin"}'

composer identity issue -c admin@pbn -f restadmin.card -u restadmin -a "resource:org.hyperledger.composer.system.NetworkAdmin#restadmin"

composer card import -f  restadmin.card

composer network ping -c restadmin@pbn

sed -e 's/localhost:7051/peer0.org1.example.com:7051/' -e 's/localhost:7053/peer0.org1.example.com:7053/' -e 's/localhost:7054/ca.org1.example.com:7054/'  -e 's/localhost:7050/orderer.example.com:7050/'  < $HOME/.composer/cards/restadmin@pbn/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/restadmin@pbn/ 




#launch REST
docker run \
-d \
-e COMPOSER_CARD=${COMPOSER_CARD} \
-e COMPOSER_NAMESPACES=${COMPOSER_NAMESPACES} \
-e COMPOSER_AUTHENTICATION=${COMPOSER_AUTHENTICATION} \
-e COMPOSER_MULTIUSER=${COMPOSER_MULTIUSER} \
-e COMPOSER_PROVIDERS="${COMPOSER_PROVIDERS}" \
-e COMPOSER_DATASOURCES="${COMPOSER_DATASOURCES}" \
-v ~/.composer:/home/composer/.composer \
--name rest \
--network composer_default \
-p 3000:3000 \
myorg/composer-rest-server

docker logs -f rest


# Add participants

composer card delete -c ashok@pbn
composer card delete -c vinay@pbn

rm ashok_exp.card
rm vinay_exp.card

composer participant add -c admin@pbn -d '{"$class":"org.example.pbn.Payer","payerKey":"ashok", "name":"ashok", "address":"address","email":"ashok@payerA.com"}'
composer participant add -c admin@pbn -d '{"$class":"org.example.pbn.Payer","payerKey":"vinay", "name":"vinay", "address":"address","email":"vinay@payerB.com"}'

composer identity issue -c admin@pbn -f ashok.card -u ashok -a "resource:org.example.pbn.Payer#ashok"
composer identity issue -c admin@pbn -f vinay.card -u vinay -a "resource:org.example.pbn.Payer#vinay"

composer card import -f ashok.card
composer card import -f vinay.card

sed -e 's/localhost:7051/peer0.org1.example.com:7051/' -e 's/localhost:7053/peer0.org1.example.com:7053/' -e 's/localhost:7054/ca.org1.example.com:7054/'  -e 's/localhost:7050/orderer.example.com:7050/'  < $HOME/.composer/cards/ashok@pbn/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/ashok@pbn/ 

sed -e 's/localhost:7051/peer0.org1.example.com:7051/' -e 's/localhost:7053/peer0.org1.example.com:7053/' -e 's/localhost:7054/ca.org1.example.com:7054/'  -e 's/localhost:7050/orderer.example.com:7050/'  < $HOME/.composer/cards/vinay@pbn/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/vinay@pbn/ 

composer card export -f ashok_exp.card -c ashok@pbn ; rm ashok.card
composer card export -f vinay_exp.card -c vinay@pbn ; rm vinay.card


