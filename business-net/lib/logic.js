'use strict';
/**
 * Transction processor functions
 * 
 * Ref: https://hyperledger.github.io/composer/latest/reference/js_scripts
 */

/**
 * Claim transaction
 * @param {org.uspc.pbnet.ClaimTransaction} claimTransaction
 * @transaction
 */
async function claimTransaction(tx) {

    // Get the asset registry for the asset.
    const assetRegistry = await getAssetRegistry('org.uspc.pbnet.Claim');
    // Update the asset in the asset registry.
    await assetRegistry.update(tx.claim);


    // Emit an event for the new claim transaction.
    let event = getFactory().newEvent('org.uspc.pbnet', 'ClaimNotification');
    event.claim = tx.claim;
    emit(event);
}


/**
 * Remove all high valued claims
 * @param {org.uspc.pbnet.RemoveHighValuedClaims} remove - the remove to be processed
 * @transaction
 */
/*async function removeHighValuedClaims(remove) {

    let assetRegistry = await getAssetRegistry('org.uspc.pbnet.Claim');
    let results = await query('selectClaimsWithHighValue');

    for (let n = 0; n < results.length; n++) {
        let claim = results[n];

        // emit a notification that a claim was removed
        let removeNotification = getFactory().newEvent('org.uspc.pbnet','RemoveClaimNotification');
        removeNotification.claim = claim;
        emit(removeNotification);
        await assetRegistry.remove(claim);
    }
}*/