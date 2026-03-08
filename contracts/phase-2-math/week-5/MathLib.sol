// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

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

    /// @notice Adds a and b, returning the lower 256 bits and an overflow flag
    /// @dev If overflow occurs, the bool is true and uint256 holds the wrapped value
    /// @dev If no overflow, the bool is false and uint256 holds the exact sum
    function fullAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (uint256, bool) {
        // YOUR CODE HERE

        unchecked {
            uint256 sum = a + b;
            return (sum, sum < a); // if the sum is less than an input, it wrapped
        }
    }

    /// @notice Computes (a + b) / 2 without intermediate overflow
    /// @dev Must work for any uint256 inputs, even if a + b > type(uint256).max
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // YOUR CODE HERE
        (uint256 sum, bool overflow) = fullAdd(a, b);

        return (sum >> 1) + (overflow ? (1 << 255) : 0);
    }

    /// @notice Computes x^n / k without intermediate overflow
    /// @dev Must not revert if the final answer fits in uint256
    /// @dev Must use mulDiv to handle intermediate overflow
    /// @dev n = 0 should return 1 / k (using divUp or regular div, your choice)
    function powDiv(
        uint256 x,
        uint256 n,
        uint256 k
    ) internal pure returns (uint256) {
        // YOUR CODE HERE
        if (n == 0) {
            return divUp(1, k);
        }
    }
}
