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
        Collection::add_item(&account, b"item1", 100);
        // Collection should not be empty
        assert!(
            Collection::size(&account) == 1,
            3
        );
        // Add another item to collection
        Collection::add_item(&account, b"item2", 200);
        // Collection should now have 2 items
        assert!(
            Collection::size(&account) == 2,
            4
        );
    }

    #[test]
    public fun test_find_item_in_collection_by_item_id(){
        let account = get_account();
        // Start collection
        Collection::start_collection(&account);
        // Add items to collection
        Collection::add_item(&account, b"item1", 200);
        Collection::add_item(&account, b"item2", 100);
        let item1 = Collection::find_item_in_collection(&account, 1);
        let item2 = Collection::find_item_in_collection(&account, 2);
        // Check that item1 is correct
        assert!(
            Collection::create_item(1, b"item1", 200) == item1,
            5
        );
        // Check that item2 is correct
        assert!(
            Collection::create_item(2, b"item2", 100) == item2,
            6
        );
    }

    #[test]
    public fun test_get_all_items(){
        let account = get_account();
        // Start collection
        Collection::start_collection(&account);
        // Add items to collection
        Collection::add_item(&account, b"item1", 200);
        Collection::add_item(&account, b"item2", 100);
        let items = Collection::get_all_items(&account);
        assert!(
            Collection::create_item(2, b"item2", 100) == vector::pop_back<Collection::Item>(&mut items),
            7
        );
        assert!(
            Collection::create_item(1, b"item1", 200) == vector::pop_back<Collection::Item>(&mut items),
            8
        );
    }

    #[test, expected_failure]
    public fun test_find_item_in_collection_by_item_id_should_abort_if_item_do_not_exist(){
        let account = get_account();
        // Start collection
        Collection::start_collection(&account);
        // Add items to collection
        Collection::add_item(&account, b"item1", 200);
        Collection::add_item(&account, b"item2", 100);
        // Should abort if item does not exist
        Collection::find_item_in_collection(&account, 3);
    }

    #[test]
    public fun test_destroy_collection(){
        let account = get_account();
        let addr = signer::address_of(&account);
        // Start collection
        Collection::start_collection(&account);
        // Collection should exist
        assert!(
            Collection::check_exists(addr) == true,
            9
        );
        // Destroy collection
        Collection::destroy_collection(&account);
        // Collection should not exist anymore
        assert!(
            Collection::check_exists(addr) == false,
            10
        );
    }
}
