// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin-contracts-5.2.0/token/ERC20/IERC20.sol";
import "@openzeppelin-contracts-5.2.0/token/ERC20/utils/SafeERC20.sol";
import {IERC3156FlashBorrower, IERC3156FlashLender} from "./IERC3156.sol";

contract FlashBorrower is IERC3156FlashBorrower {
    error InvalidLender(address lender);

    using SafeERC20 for IERC20;

    bytes32 public constant CALLBACK_SUCCESS =
        keccak256("ERC3156FlashBorrower.onFlashLoan");

    address public immutable lender;

    constructor(address _lender) {
        lender = _lender;
    }

    /// @notice Triggers the flash loan from the lender
    function initiateLoan(address token, uint256 amount) external {
        // YOUR CODE HERE

        IERC3156FlashLender(lender).flashLoan(
            IERC3156FlashBorrower(address(this)),
            token,
            amount,
            ""
        );
    }

    /// @notice Callback invoked by the lender mid-flashLoan
    /// @dev Must:
    ///      1. Revert if msg.sender != lender
    ///      2. Approve lender for amount + fee
    ///      3. Return CALLBACK_SUCCESS
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external returns (bytes32) {
        // YOUR CODE HERE
        require(msg.sender == lender, InvalidLender(lender));

        IERC20(token).approve(lender, amount + fee);

        return CALLBACK_SUCCESS;
    }
}
