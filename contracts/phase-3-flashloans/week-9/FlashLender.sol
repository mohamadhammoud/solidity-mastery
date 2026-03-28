// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin-contracts-5.2.0/token/ERC20/IERC20.sol";
import "@openzeppelin-contracts-5.2.0/token/ERC20/utils/SafeERC20.sol";
import {IERC3156FlashBorrower, IERC3156FlashLender} from "./IERC3156.sol";

contract FlashLender is IERC3156FlashLender {
    error UnsupportedToken(address token);
    error CallbackFailed();
    error RepaymentFailed();

    using SafeERC20 for IERC20;

    bytes32 public constant CALLBACK_SUCCESS =
        keccak256("ERC3156FlashBorrower.onFlashLoan");

    uint256 public constant FEE_BPS = 10;
    uint256 public constant BPS_DENOMINATOR = 10_000;

    IERC20 public immutable supportedToken;

    constructor(address _token) {
        supportedToken = IERC20(_token);
    }

    /// @notice Returns lender balance for supported token, 0 otherwise
    function maxFlashLoan(address token) external view returns (uint256) {
        // YOUR CODE HERE
        if (token != address(supportedToken)) {
            return 0;
        }
        return IERC20(token).balanceOf(address(this));
    }

    /// @notice Returns fee for a given amount. Reverts if token not supported.
    function flashFee(
        address token,
        uint256 amount
    ) external view returns (uint256) {
        // YOUR CODE HERE
        // hint: revert if token != address(supportedToken)
        require(token == address(supportedToken), UnsupportedToken(token));
        return (amount * FEE_BPS) / BPS_DENOMINATOR;
    }

    /// @notice Executes the flash loan
    /// @dev Flow:
    ///      1. Validate token is supported
    ///      2. Compute fee
    ///      3. Transfer amount to receiver
    ///      4. Call receiver.onFlashLoan(msg.sender, token, amount, fee, data)
    ///      5. Verify return value == CALLBACK_SUCCESS
    ///      6. Pull back amount + fee via transferFrom
    ///      7. Verify balance increased by fee
    ///      8. Return true
    function flashLoan(
        IERC3156FlashBorrower receiver,
        address token,
        uint256 amount,
        bytes calldata data
    ) external returns (bool) {
        // YOUR CODE HERE
        require(token == address(supportedToken), UnsupportedToken(token));

        uint256 balanceBefore = IERC20(token).balanceOf(address(this));
        uint256 fee = (amount * FEE_BPS) / BPS_DENOMINATOR;

        IERC20(token).safeTransfer(address(receiver), amount);

        bytes32 value = receiver.onFlashLoan(
            msg.sender,
            token,
            amount,
            fee,
            data
        );
        require(value == CALLBACK_SUCCESS, CallbackFailed());

        IERC20(token).safeTransferFrom(
            address(receiver),
            address(this),
            amount + fee
        );

        uint256 balanceAfter = IERC20(token).balanceOf(address(this));

        require(balanceAfter >= balanceBefore + fee, RepaymentFailed());
        return true;
    }
}
