![License](https://img.shields.io/github/license/no-hive/invoice_nfts?style=flat&color=purple)
![Commit Count](https://img.shields.io/github/commit-activity/t/no-hive/invoice_nfts?style=flat&color=blue)
![Last Commit](https://img.shields.io/github/last-commit/no-hive/invoice_nfts?style=flat&color=blue)
![Tests](https://github.com/no-hive/invoice_nfts/actions/workflows/tests.yml/badge.svg)
![coverage](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/no-hive/invoice_nfts/gh-pages/coverage.json?style=flat&color=32CB55)

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
