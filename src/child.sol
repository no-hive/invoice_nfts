// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// this contract is supposed to be built via factory.sol
// it serves as one-time transfer intermediary
contract Child {
    address public immutable ADMIN_ADDRESS;

    address public immutable SENDER_ADDRESS;

    uint256 public immutable TRANSFER_SUM;

    constructor(address _adminAddress, address _senderAddress, uint256 _transferSum) {
        ADMIN_ADDRESS = _adminAddress;
        SENDER_ADDRESS = _senderAddress;
        TRANSFER_SUM = _transferSum;
    }

    // FALLBACK function is vital here
    // Simple transfer flow:
    // 1. Execute transfer
    // 2. After transfer is completed, forward funds to the adminAddress.
    // 3. Once the operation is finished, notify the factory contract to update the status.
    // The question: Do we need to define Sender Address?
    // Also we need to record the exact transfer time to pass it back to main contract and later to the invoice itself.
}
