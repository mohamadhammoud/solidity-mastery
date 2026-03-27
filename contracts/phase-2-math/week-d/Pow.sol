// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLib {
    /// @notice Computes x^n using exponentiation by squaring
    function pow(uint256 x, uint256 n) internal pure returns (uint256) {
        // YOUR CODE HERE
        // 1. Start with result = 1
        // 2. Loop while n > 0
        //    a. If n is odd (n & 1 == 1), multiply result by x
        //    b. Square x (x = x * x)
        //    c. Shift n right by 1 (n >>= 1)
        // 3. Return result

        uint256 result = 1;

        while (n > 0) {
            if (n & 1 == 1) {
                result *= x;
            }
            x = x * x;
            n = n >> 1;
        }
        return result;
    }
}
