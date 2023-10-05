# nft-collection

This NFT collection is kind of like Ethereum's [ERC1155](https://eips.ethereum.org/EIPS/eip-1155) with a single token Id and multiple copies.

### Compile

```bash
aptos move compile --named-addresses publisher=<address_of_publisher>,source_addr=<sorce_address_for_resource_account>,admin_addr=<admin_address>
```

### Deploy

```bash
aptos move create-resource-account-and-publish-package --seed <any-seed> --address-name publisher --profile default --named-addresses source_addr=<default-address>
```
