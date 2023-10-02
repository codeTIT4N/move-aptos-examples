#[test_only]
module publisher::NFTMarketplace_tests{
    
    use std::signer;
    use std::vector;
    use std::unit_test;

    use publisher::NFTMarketplace;

    fun get_account(): signer {
       vector::pop_back(&mut unit_test::create_signers_for_testing(1))
    }

    // TODO: Add tests for NFTMarketplace

}
