// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

library FixedPointLib {
    uint256 constant SCALE = 1e18;

    /// @notice Multiplies two 18-decimal fixed-point numbers
    /// @dev Example: mulFP(1.5e18, 2e18) should return 3e18
    function mulFP(uint256 a, uint256 b) internal pure returns (uint256) {
        // YOUR CODE HERE

        // return (a * b) / SCALE;
        return Math.mulDiv(a, b, SCALE);
    }

    /// @notice Divides two 18-decimal fixed-point numbers
    /// @dev Example: divFP(3e18, 2e18) should return 1.5e18
    function divFP(uint256 a, uint256 b) internal pure returns (uint256) {
        // YOUR CODE HERE
        // return (a * SCALE) / b;
        return Math.mulDiv(a, SCALE, b);
    }

    /// @notice Converts a value from one decimal scale to another
    /// @dev Example: convert(1e18, 18, 6) should return 1e6
    function convert(
        uint256 value,
        uint8 from, // 18
        uint8 to // 6
    ) internal pure returns (uint256) {
        // YOUR CODE HERE

        if (from > to) {
            return (value / (10 ** (from - to)));
        } else {
            return (value * (10 ** (to - from)));
        }
    }

    /// @notice Computes price in terms of a different decimal token
    /// @dev Given: amount of tokenA (decimalsA), price per tokenA in 18 decimals
    /// @dev Returns: equivalent value in tokenB decimals
    /// @dev Example: An amount of 1.5 ETH (18 dec) at price 2000e18 = 3000 USDC (6 dec)
    function computeValue(
        uint256 amount,
        uint8 amountDecimals,
        uint256 priceInWad,
        uint8 targetDecimals
    ) internal pure returns (uint256) {
        // YOUR CODE HERE

        uint256 valueInAmountDecimals = mulFP(amount, priceInWad);
        return convert(valueInAmountDecimals, amountDecimals, targetDecimals);
    }

    /// @notice Multiplies two 18-decimal fixed-point numbers, rounding UP
    /// @dev Example: mulFPUp(1e18, 1e18) = 1e18 (exact, no rounding needed)
    /// @dev Example: mulFPUp(1, 3) = 1 (because 1*3/1e18 rounds up from 0 to 1)
    function mulFPUp(uint256 a, uint256 b) internal pure returns (uint256) {
        // YOUR CODE HERE
        return Math.mulDiv(a, b, SCALE, Math.Rounding.Ceil);
    }

    /// @notice Divides two 18-decimal fixed-point numbers, rounding UP
    /// @dev Example: divFPUp(1e18, 3e18) should be slightly more than divFP(1e18, 3e18)
    function divFPUp(uint256 a, uint256 b) internal pure returns (uint256) {
        // YOUR CODE HERE
        return Math.mulDiv(a, SCALE, b, Math.Rounding.Ceil);
    }
}
