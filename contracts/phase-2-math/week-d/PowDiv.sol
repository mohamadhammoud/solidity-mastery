// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

library MathLib {
    /// @notice Computes x^n / k without intermediate overflow on the final step
    /// @dev Defers division by k to the last multiplication
    function powDiv(
        uint256 x,
        uint256 n,
        uint256 k
    ) internal pure returns (uint256) {
        if (n == 0) {
            return 1 / k;
        }

        uint256 result = 1;

        while (n > 1) {
            if (n & 1 == 1) {
                result = result * x;
            }
            x = x * x;
            n >>= 1;
        }

        // Only the final step uses mulDiv to safely compute result * x / k
        return Math.mulDiv(result, x, k);
    }
}
