module publisher::NFTCollection {

    use std::error;
    use std::string;
    use std::vector;

    use aptos_token::token;
    use std::signer;
    use std::string::String;
    use aptos_token::token::TokenDataId;
    use aptos_framework::account::SignerCapability;
    use aptos_framework::resource_account;
    use aptos_framework::account;
    use aptos_framework::timestamp;

    struct NFTData has key {
        // Storing the signer capability here, so the module can programmatically sign for transactions
        signer_cap: SignerCapability,
        token_data_id: TokenDataId,
    }

    const ENOT_AUTHORIZED: u64 = 1;

    // constructor
    fun init_module(resource_signer: &signer) {
        let collection_name = string::utf8(b"The colors collection");
        let description = string::utf8(b"Colorful collection discription");
        let collection_uri = string::utf8(b"https://ipfs.io/ipfs/QmbuzAWdhpBq4qcAN6JD2k5ce7uKomZynQBuELJ8o8c7ZW");
        let token_name = string::utf8(b"Colors NFT");
        let token_description = string::utf8(b"Colors create beauty");
        let token_uri = string::utf8(b"https://ipfs.io/ipfs/QmZ5cimfzWZ754CYBaWd7UgRcfS9vGKztgpm96W26Qem6L/testNFTs/1.json");
        let maximum_supply = 0;

        let mutate_setting = vector<bool>[ false, false, true ];

        token::create_collection(resource_signer, collection_name, description, collection_uri, maximum_supply, mutate_setting);

        let token_data_id = token::create_tokendata(
            resource_signer,
            collection_name,
            token_name,
            token_description,
            0,
            token_uri,
            signer::address_of(resource_signer),
            1,
            0,
            token::create_token_mutability_config(
                &vector<bool>[ true, true, false, false, true ]
            ),
            vector<String>[string::utf8(b"given_to")],
            vector<vector<u8>>[b""],
            vector<String>[ string::utf8(b"address") ],
        );

        let resource_signer_cap = resource_account::retrieve_resource_account_cap(resource_signer, @publisher);
        move_to(resource_signer, NFTData {
            signer_cap: resource_signer_cap,
            token_data_id
        });
    }

    // update the token uri
    public entry fun update_token_uri(caller: &signer, new_uri: String) {
        let caller_address = signer::address_of(caller);
        assert!(caller_address == @admin_addr, error::permission_denied(ENOT_AUTHORIZED));
        //let nft_data = borrow_global_mut<NFTData>(@publisher);
        //let token_data_id = nft_data.token_data_id;
        // TODO: complete this

    }

    // TODO: Add more functions

}
