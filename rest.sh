
docker stop mongo
docker rm mongo

docker stop rest
docker rm rest

#mongo
docker run -d --name mongo --network composer_default -p 27017:27017 mongo

cd ~/pbnet/dockertmp
docker build -t pbnet/composer-rest-server .


cd ~/pbnet

source envvars.txt
#source envvar_security.txt

echo $COMPOSER_CARD
echo $COMPOSER_PROVIDERS



##############################################################


#restadmin

rm -fr ~/.composer/cards/restadmin@pbnet
composer card delete -c restadmin@pbnet


composer participant add -c admin@pbnet -d '{"$class":"org.hyperledger.composer.system.NetworkAdmin", "participantId":"restadmin"}'

composer identity issue -c admin@pbnet -f restadmin.card -u restadmin -a "resource:org.hyperledger.composer.system.NetworkAdmin#restadmin"

composer card import -f  restadmin.card

composer network ping -c restadmin@pbnet

composer card list

sed \
-e 's/localhost:7051/peer0.org1.example.com:7051/' \
-e 's/localhost:8051/peer1.org1.example.com:8051/' \
-e 's/localhost:8051/peer1.org1.example.com:9051/' \
-e 's/localhost:7053/peer0.org1.example.com:7053/' \
-e 's/localhost:8053/peer1.org1.example.com:8053/' \
-e 's/localhost:8053/peer1.org1.example.com:9053/' \
-e 's/localhost:7054/ca.org1.example.com:7054/'  \
-e 's/localhost:7050/orderer.example.com:7050/'  \
< $HOME/.composer/cards/restadmin@pbnet/connection.json  > /tmp/connection.json && cp -p /tmp/connection.json $HOME/.composer/cards/restadmin@pbnet/ 




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
pbnet/composer-rest-server

