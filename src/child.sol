// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// this contract is supposed to be built via factory.sol
// it serves as one-time transfer intermediary
contract Child {
    //    using SafeERC20 for IERC20;
    address public immutable ADMIN_ADDRESS;

    uint256 public immutable TRANSFER_SUM;

    address public immutable USDT_ADDRESS = address(0);

    constructor(address _adminAddress, uint256 _transferSum) {
        ADMIN_ADDRESS = _adminAddress;
        TRANSFER_SUM = _transferSum;
    }


  function Deposit(uint256 amount, address recipient) external {
        require(amount = TRANSFER_SUM, "Amount must be greater than zero");

        IERC20(USDT_ADDRESS).safeTransferFrom(msg.sender, ADMIN_ADDRESS, amount);

  }

    // FALLBACK function is vital here
    // Simple transfer flow:
    // 1. Execute transfer
    // 2. After transfer is completed, forward funds to the adminAddress.
    // 3. Once the operation is finished, notify the factory contract to update the status.
    // The question: Do we need to define Sender Address?
    // Also we need to record the exact transfer time to pass it back to main contract and later to the invoice itself.
}
