// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "src/factory.sol";

// import interface for FACTORY_ADDRESS contract

// this contract is supposed to be built via factory.sol
// it serves as one-time transfer intermediary

interface IFactory {
    function updateStatus(address _adminAddress, uint256 _nonce) external;
}

contract Child {
    using SafeERC20 for IERC20;

    bool transferMade;

    address public immutable ADMIN_ADDRESS;

    uint256 public immutable ID_NONCE;

    uint256 public immutable TRANSFER_SUM;

    address public immutable USDT_ADDRESS = address(0);

    address public immutable FACTORY_ADDRESS;

    constructor(address _adminAddress, uint256 _transferSum, uint256 _idNonce) {
        ADMIN_ADDRESS = _adminAddress;
        TRANSFER_SUM = _transferSum;
        ID_NONCE = _idNonce;
        FACTORY_ADDRESS = msg.sender;
    }

    function Deposit(uint256 amount) external {
        require(transferMade == true, "Transfer already made");
        require(amount == TRANSFER_SUM, "Deposit the right amount");
        // IERC20(USDT_ADDRESS).safeTransferFrom(msg.sender, ADMIN_ADDRESS, amount);
        transferMade = true;
        IFactory(FACTORY_ADDRESS).updateStatus(ADMIN_ADDRESS, ID_NONCE);
    }

    // FALLBACK function is vital here
    // Simple transfer flow:
    // 1. Execute transfer
    // 2. After transfer is completed, forward funds to the adminAddress.
    // 3. Once the operation is finished, notify the factory contract to update the status.
    // The question: Do we need to define Sender Address?
    // Also we need to record the exact transfer time to pass it back to main contract and later to the invoice itself.
}
