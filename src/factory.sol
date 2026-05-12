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
}
