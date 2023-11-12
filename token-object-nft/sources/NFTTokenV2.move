module publisher::nft_token_v2 {

    use std::error;
    use std::signer;
    use aptos_token_objects::royalty::Royalty;
    use aptos_token_objects::collection;
    use aptos_token_objects::token;
    use std::option;
    use aptos_framework::string::{String, Self};


    /// Only admin can call this function
    const ENOT_AUTHORIZED: u64 = 1;



    #[resource_group_member(group = aptos_framework::object::ObjectGroup)] 
    struct NFTData has key{
        collection_name: string::String,
        mutator: token::MutatorRef,
        admin: address,
    }
    
    fun init_module(creator: &signer) {
        let collection_name = string::utf8(b"Example Collection");
        let collection_description = string::utf8(b"Example Collection Description");

        let constructor_ref = &collection::create_unlimited_collection(
            creator,
            collection_description,
            collection_name,
            option::none<Royalty>(),
            string::utf8(b""), // collection uri
        );
        let nft_data = NFTData {
            collection_name,
            mutator: mutator_ref,
            admin: @admin_addr
        };
    }

    public entry fun update_admin_address(caller: &signer, new_lync_admin_address: address) acquires NFTData {
        let caller_address = signer::address_of(caller);
    }

    // TODO: Complete




}
