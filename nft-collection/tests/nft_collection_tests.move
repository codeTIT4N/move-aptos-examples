#[test_only]
module publisher::nft_collection_tests{

    use std::signer;
    use std::unit_test;
    use std::vector;

    use publisher::NFTCollection;

    fun get_account(): signer {
       vector::pop_back(&mut unit_test::create_signers_for_testing(1))
    }

    #[test]
    fun test_nft_collection(){
        let account = get_account();
        let addr = signer::address(account);
        assert!(exists<NFTCollection>(addr) == true,0);
    }

}
