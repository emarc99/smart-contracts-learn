// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./MultiSigWallet.sol";

contract MultiSigFactory {

    MultiSigWallet[] multisigClones;

    function createMultisigWallet(uint8 _quorum, address[] memory _validSigners) external returns (MultiSigWallet newMulsig_, uint256 length_) {

        newMulsig_ = new MultiSigWallet(_quorum, _validSigners);

        multisigClones.push(newMulsig_);

        length_ = multisigClones.length;
    }

    function getMultiSigClones() external view returns(MultiSigWallet[] memory) {
        return multisigClones;
    }
}