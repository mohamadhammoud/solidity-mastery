// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLib {
    /// @notice Computes the integer square root of n (rounds down)
    /// @dev Uses Heron's method (Babylonian method)
    /// @dev Returns the largest r such that r * r <= n
    function sqrt(uint256 n) internal pure returns (uint256) {
        // YOUR CODE HERE
        // 1. Handle n = 0 (return 0)
        // 2. Start with guess = n
        // 3. Loop: compute next = (guess + n/guess) / 2
        // 4. If next >= guess, stop and return guess
        // 5. Otherwise, guess = next, repeat

        if (n <= 1) return n;

        // first guess is (n + n/n) / 2 so it is same as (n + 1) / 2 =  n / 2 + 1
        uint256 guess = n / 2 + 1;

        while (true) {
            uint256 next = (guess + n / guess) / 2;
            if (next >= guess) return guess;
            guess = next;
        }
    }
}
