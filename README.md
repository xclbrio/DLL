# Decentralized Liquidity Layer
Excalibur_ solidity smart contracts for __DLL__

[![](https://img.shields.io/badge/project-Excalibur__-ef5777.svg?style=popout-square)](https://github.com/xclbrio)
![GitHub](https://img.shields.io/github/license/xclbrio/ipfsWebDist.svg?style=flat-square)
![GitHub](https://img.shields.io/badge/solidity-0.5.0-383838.svg?style=popout-square)
[![GitHub release](https://img.shields.io/travis/com/xclbrio/DLL.svg?style=flat-square)](https://travis-ci.com/xclbrio/DLL)
[![Gitter](https://img.shields.io/gitter/room/:user/:repo.svg?style=flat-square)](https://gitter.im/xclbrio/Lobby)

# Description

The protocol of an exchange is implemented through the use of smart contracts on the Ethereum blockchain- an open source, which does not charge any additional fees, with the exception of gas cost on the Ethereum network. Smart contracts are written in Solidity language.

# DLL Algorithm

__DLL__ is a concept like the __Ethereum__ and __Bitcoin__ networks. In __DLL__ there is also a stream of objects that need to be calculated for a reward. In this concept, each DEX is a subpool with Takers, users who can execute orders entering the subpool, for which DEX receives an award in the form of commission and may, at its discretion, share this reward with its users.

Each product that uses Excalibur_ protocol for exchange and wants to connect to DLL must add the address of the admin wallet to the smart protocol contract. This address will identify the product in the global pool. Further, each DEX that participates in the global pool will sign each order created on this DEX using the address that was previously registered in the contract. Thus, when executing an order, you can always track which DEX it was created from and limit the use of the global pool to DEX which are registered in it.

If the product is not registered in the global pool, it is still able to connect to the general flow of orders, but is not able to execute them, as the smart contract of protocol verifies the address of the order creator’s exchange and the address of the executor each time an exchange is done.



Communication channels
======================

Email: support@xclbr.io

Gitter chat: https://gitter.im/xclbrio/Lobby

Issues
=======

[Issues page](https://github.com/xclbrio/DLL/issues) for reports

License
=======

[Apache v2.0](https://github.com/xclbrio/ipfsWebDist/blob/master/LICENSE.md) © 2018 ExcaliburAlpha OÜ
