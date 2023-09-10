#[test_only]
module publisher::Collection_tests {
    use std::signer;
    use std::unit_test;
    use std::vector;

    use publisher::Collection;

    fun get_account(): signer {
       vector::pop_back(&mut unit_test::create_signers_for_testing(1))
    }

    #[test]
    public fun test_start_collection() {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Collection should not exist
        assert!(
            Collection::check_exists(addr) == false,
            0
        );
        // Start collection
        Collection::start_collection(&account);
        // Collection exists
        assert!(
            Collection::check_exists(addr) == true,
            1
        );
        // Collection is empty
        assert!(
            Collection::size(&account) == 0,
            2
        );
    }

    #[test]
    public fun test_add_item(){
        let account = get_account();
        Collection::start_collection(&account);
        // Add item to collection
        Collection::add_item(&account, 1, 25);
        // Collection should not be empty
        assert!(
            Collection::size(&account) == 1,
            3
        );
        // Add another item to collection
        Collection::add_item(&account, 2, 50);
        // Collection should have 2 items
        assert!(
            Collection::size(&account) == 2,
            4
        );
    }
    // @todo: add more tests

}
