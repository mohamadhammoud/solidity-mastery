// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLib {
    /// @notice Divides a by b, rounding up instead of down
    /// @dev Must revert if b is zero
    /// @dev Must handle the case where a is zero
    /// @dev Must not overflow for any valid inputs
    function divUp(uint256 a, uint256 b) internal pure returns (uint256) {
        // YOUR CODE HERE
        if (b == 0) {
            revert();
        }

        if (a == 0) {
            return 0;
        }

        return ((a - 1) / b) + 1;
    }
}
