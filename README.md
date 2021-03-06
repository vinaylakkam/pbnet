# pbnet (Payer Blockchain Network)

## Setup
---

**ref**: https://hyperledger.github.io/composer/latest/installing/installing-prereqs.html

**On Ubuntu, install pre-requisites** (~4 mins) 

- `curl -O https://hyperledger.github.io/composer/latest/prereqs-ubuntu.sh`
- `chmod u+x prereqs-ubuntu.sh`
- `./prereqs-ubuntu.sh`

**Install Development Environment - Node modules** (~10 mins)

- `sudo chown -R ubuntu /usr/local/lib`
- `sudo apt install npm`
- `npm install -g composer-cli@0.20`
- `npm install -g composer-rest-server@0.20`
- `npm install -g generator-hyperledger-composer@0.20`
- `npm install -g yo`
- `npm install -g composer-playground@0.20`

## Run
---

**ref**: https://hyperledger.github.io/composer/latest/tutorials/developer-tutorial

- `cd && git clone https://bitbucket.org/vlakkam/pbnet.git`

- `cd pbnet`
- `bash up.sh`

## Use it 
---

**ref**: https://hyperledger.github.io/composer/latest/tutorials/developer-tutorial


- `cd ~./pbnet`

Create a REST API

- `composer-rest-server -c admin@pbnet -n never -u true -d PBN -w true`

Open: http://localhost:3000 


## Upgrade the business network
---
**ref**: https://hyperledger.github.io/composer/latest/business-network/upgrading-bna

Update the version property in package.json

Package the business network with new version

- ` cd ~./pbnet/business-net && composer archive create --sourceType dir --sourceName . -a pbnet@0.0.9.bna`

Install

- `composer network install --card PeerAdmin@pbnet --archiveFile pbnet@0.0.9.bna`

Upgrade to the business network that was installed

- `composer network upgrade --card PeerAdmin@pbnet -n pbnet -V 0.0.9`

Regenerate REST API

- `composer-rest-server --card admin@pbnet -n never -u true -d N -w true`

Regenerate UI app

- `yo hyperledger-composer:angular`
