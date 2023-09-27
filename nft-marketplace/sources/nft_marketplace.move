module publisher::Marketplace {

    use std::signer;
    use std::string::String;
    use aptos_framework::guid; 
    use aptos_framework::coin;
    use aptos_framework::account;
    use aptos_framework::timestamp;
    use aptos_std::event::{Self, EventHandling};
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

}
