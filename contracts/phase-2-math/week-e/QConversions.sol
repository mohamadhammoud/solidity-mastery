// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

library QConversions {
    uint256 constant WAD = 1e18;
    uint256 constant Q64 = 2 ** 64;

    /// @notice Converts 18-decimal fixed point to UQ64.64
    /// @dev Rounds down
    function wadToQ64(uint256 wadValue) internal pure returns (uint256) {
        // YOUR CODE HERE

        return Math.mulDiv(wadValue, Q64, WAD);
    }

    /// @notice Converts UQ64.64 to 18-decimal fixed point
    /// @dev Rounds down
    function q64ToWad(uint256 q64Value) internal pure returns (uint256) {
        // YOUR CODE HERE
        return Math.mulDiv(q64Value, WAD, Q64);
    }
}
