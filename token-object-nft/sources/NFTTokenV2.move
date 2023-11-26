module publisher::nft_token_v2 {

    use std::error;
    use std::signer;
    use aptos_token_objects::royalty::Royalty;
    use aptos_token_objects::collection;
    use aptos_token_objects::token;
    use std::option;
    use aptos_framework::string;

    /// Only admin can call this function
    const ENOT_AUTHORIZED: u64 = 1;



    #[resource_group_member(group = aptos_framework::object::ObjectGroup)] 
    struct NFTData has key{
        collection_name: string::String,
        mutator: token::MutatorRef,
        admin: address,
    }
    
    fun init_module(resource_signer: &signer) {
        let collection_name = string::utf8(b"Example Collection");
        let collection_description = string::utf8(b"Example Collection Description");
        let token_name = string::utf8(b"Example Token");
        let token_description = string::utf8(b"Example Token Description");
        let uri = string::utf8(b"");

        let _ = &collection::create_unlimited_collection(
            resource_signer,
            collection_description,
            collection_name,
            option::none<Royalty>(),
            string::utf8(b""), // collection uri
        );

        let constructor_ref = token::create(
            resource_signer,
            collection_name,
            token_description,
            token_name,
            option::none<Royalty>(),
            uri,
        );

        let token_mutator = token::generate_mutator_ref(&constructor_ref);
        
        let nft_data = NFTData {
            collection_name,
            mutator: token_mutator,
            admin: @admin_addr
        };
        move_to(resource_signer, nft_data);
    }

    public entry fun update_admin_address(caller: &signer, new_admin: address) acquires NFTData {
        let caller_address = signer::address_of(caller);
        let nft_data = borrow_global_mut<NFTData>(@publisher);
        assert!(caller_address == nft_data.admin, error::permission_denied(ENOT_AUTHORIZED));
        nft_data.admin = new_admin;
    }

    public entry fun update_token_uri(caller: &signer, new_uri: string::String) acquires NFTData {
        let caller_address = signer::address_of(caller);
        let nft_data = borrow_global<NFTData>(@publisher);
        assert!(caller_address == nft_data.admin, error::permission_denied(ENOT_AUTHORIZED));
        let mutator_ref = &nft_data.mutator;
        token::set_uri(mutator_ref, new_uri);
    }


    // TODO: transfer burn etc


}
