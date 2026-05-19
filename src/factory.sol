// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Child} from "src/child.sol";

contract Factory {
    // ============================================================
    //                  USER ENCRYPTED DATA
    // ============================================================

    // Stores encrypted personal data for a user.
    // These values are expected to be encrypted off-chain before submission.
    struct UserData {
        string encryptedName;
        string encryptedAddress;
    }

    // Maps user address to their encrypted personal data.
    mapping(address => UserData) userDataMapping;

    // ============================================================
    //                TRANSFER / CHILD CONTRACT DATA
    // ============================================================

    // This struct represents a single transfer cycle.
    // Each transfer is linked to a dedicated child contract.
    // created      - indicates that the Child contract was deployed
    // completed    - indicates that the transfer is executed (updated by child contract)
    // childAddress - deployed Child contract address responsible for execution
    struct Transfer {
        bool Created;
        bool Completed;
        address ChildContractAddress;
    }

    // Stores all transfers per user. This mapping contains all the info
    // that is needed for transfer data management.
    mapping(address => mapping(uint256 => Transfer)) public transferIdMapping;

    // Tracks per-user nonce used for generating unique transfer IDs.
    // Ensures each transfer has a unique identifier per wallet.
    mapping(address => uint256) public idNonce;

    // ============================================================
    //                CONSTRUCTOR FOR USDT ADDRESS MANAGEMENT
    // ============================================================

    // Encrypted USDT contract address provided by the Factory contract.
    address public immutable USDT_ADDRESS;

    constructor(address _USDT_address) {
        USDT_ADDRESS = _USDT_address;
    }

    // ============================================================
    //                   USER ENCRYPTED DATA MANAGEMENT
    // ============================================================

    // Updates encrypted username for caller.
    function updateUserDataEncryptedName(string memory _newEncryptedName) external {
        userDataMapping[msg.sender].encryptedName = _newEncryptedName;
    }

    // @notice Updates encrypted address for caller.
    function updateUserDataEncryptedAddress(string memory _newEncryptedAddress) external {
        userDataMapping[msg.sender].encryptedAddress = _newEncryptedAddress;
    }

    // ============================================================
    //              TRANSFER / CHILD CONTRACT DEPLOYMENT
    // ============================================================

    // Creates a new transfer and deploys a dedicated Child contract.
    // Each transfer is represented by its own Child contract instance.
    // @param _transferSum Amount is a value expected in the transfer.
    function createTransfer(uint256 _transferSum) public {
        uint256 nonce_ = idNonce[msg.sender];
        idNonce[msg.sender]++;
        address _adminAddress = msg.sender;
        Child c = new Child(_adminAddress, _transferSum, nonce_, USDT_ADDRESS);
        transferIdMapping[_adminAddress][nonce_].ChildContractAddress = address(c);
        transferIdMapping[_adminAddress][nonce_].Created = true;
    }

    // ============================================================
    //               TRANSFER / CHILD CONTRACT UPDATE
    // ============================================================

    // Called by Child contract after successful execution.
    // Only the authorized Child contract can update its transfer status.
    function updateStatus(address _adminAddress, uint256 _nonce) public {
        require(msg.sender == transferIdMapping[_adminAddress][_nonce].ChildContractAddress, "Not permitted");
        transferIdMapping[_adminAddress][_nonce].Completed = true;
    }
}
