// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./child.sol";

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
    // Transfers data
    // =============================

    struct Transfer {
        bool Created;
        bool Completed;
        bool NFTMinted;
        address ChildContractAddress;
    }

    mapping(address => mapping(uint256 => Transfer)) transferIdMapping;

    mapping(address => uint256) idNonce;

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

    function createTransfer(uint256 _transferSum) public {
        uint256 nonce_ = idNonce[msg.sender];
        idNonce[msg.sender]++;
        address _adminAddress = msg.sender;
        child c = new child (_adminAddress, _transferSum, nonce_);
        transferIdMapping[_adminAddress][nonce_].ChildContractAddress = address(c);
        transferIdMapping[_adminAddress][nonce_].Created = true;
    }

    function updateStatus(address _adminAddress, uint256 _nonce) public {
        require(msg.sender == transferIdMapping[_adminAddress][_nonce].ChildContractAddress, "Not permitted");
        transferIdMapping[_adminAddress][_nonce].Completed = true;
        // should take address and match it with the status enum and update the status.
        // then  should mint nft to admin account using encrypted details.
        //
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
