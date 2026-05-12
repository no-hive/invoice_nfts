// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Factory {
    // =============================
    // Personal data storage
    // =============================

    // this data will be replaced with encrypted personal data of the user
    struct UserData {
        string encryptedName;
        string encryptedAddress;
    }

    // that's how we connect personal address with personal encrypted data
    mapping(address => UserData) userDataMapping;

    // =============================
    // Personal data management functions
    // =============================

    // let User update encrypted name
    function updateUserDataEncryptedName(string memory _newEncryptedName) external {
        userDataMapping[msg.sender].encryptedName = _newEncryptedName;
    }

    // let User update encrypted address
    function updateUserDataEncryptedAddress(string memory _newEncryptedAddress) external {
        userDataMapping[msg.sender].encryptedAddress = _newEncryptedAddress;
    }

    // =============================
    // What to implement:
    //
    // 1. Create a transfer process:
    //    - deploy a new child contract
    //    - add an enum to track transfer statuses
    //    - pass the following data to the child contract:
    //        * transfer amount
    //        * sender address
    //        * admin address
    //
    // 2. Allow the child contract to update transfer statuses.
    //
    // 3. Connect to the NFT contract and mint NFTs
    //    when the transfer status becomes `Complete`.
    //
    // 4. Allow cancellation of unfinished transfers.
    // =============================
}
