module publisher::NFTMarketplace {

    use std::signer;
    use std::string::String;
    use aptos_framework::guid; 
    use aptos_framework::coin;
    use aptos_framework::account;
    use aptos_framework::timestamp;
    //use aptos_std::event::{Self, EventHandling};
    use aptos_std::table::{Self, Table};
    use aptos_token::token;
    use aptos_token::token_coin_swap::{list_token_for_swap, exchange_coin_for_token};

    const SELLER_CAN_NOT_BE_BUYER: u64 = 1;
    const FEE_DENOMINATOR: u64 = 10000;

    struct MarketId has store, drop, copy {
        market_name: String, 
        market_address: address, 
    }

    struct Market has key {
        market_id: MarketId,
        fee_numerator: u64,
        fee_payee: address,
        signer_cap: account::SignerCapability
    }

    struct OfferStore has key {
        offers: Table<token::TokenId, Offer> // data structure: token_id -> offer
    }

    struct Offer has drop, store {
        market_id: MarketId,
        seller: address,
        price: u64,
    }

    struct CreateMarketEvent has drop, store {
        market_id: MarketId,
        fee_numerator: u64,
        fee_payee: address,
    }

    struct ListTokenEvent has drop, store {
        market_id: MarketId,
        token_id: token::TokenId,
        seller: address,
        price: u64,
        timestamp: u64,
        offer_id: u64
    }

    struct BuyTokenEvent has drop, store {
        market_id: MarketId,
        token_id: token::TokenId,
        seller: address,
        buyer: address,
        price: u64,
        timestamp: u64,
        offer_id: u64
    }

    fun get_resource_account_cap(market_address: address): signer acquires Market {
        let market = borrow_global<Market>(market_address);
        account::create_signer_with_capability(&market.signer_cap)
    }

    fun get_royalty_fee_rate(token_id: token::TokenId): u64 {
        let royalty = token::get_royalty(token_id);
        let royalty_denominator = token::get_royalty_denominator(&royalty);
        let royalty_numerator = token::get_royalty_numerator(&royalty);
        let royalty_fee_rate = if(royalty_denominator == 0) {
            0
        } else {
            royalty_numerator / royalty_denominator
        };
        royalty_fee_rate
    }

    // TODO: Complete the implementation
}