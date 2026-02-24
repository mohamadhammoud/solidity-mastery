// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLib {
    /// @notice Adds a and b, returning the lower 256 bits and an overflow flag
    /// @dev If overflow occurs, the bool is true and uint256 holds the wrapped value
    /// @dev If no overflow, the bool is false and uint256 holds the exact sum
    function fullAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256, bool) {
        // YOUR CODE HERE
        uint256 sum;
        bool overflow;
        unchecked {
            sum = a + b;
            overflow = sum < a; // if the sum is less than an input, it wrapped
        }

        return (sum, overflow);
    }
}
