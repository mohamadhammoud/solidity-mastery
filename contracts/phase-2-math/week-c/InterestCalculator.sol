// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {FixedPointMathLib} from "solady/utils/FixedPointMathLib.sol";
import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

library InterestCalculator {
    /// @notice Computes continuously compounded interest
    /// @param principal The initial amount (in any token decimals)
    /// @param rateWad Annual interest rate in 18-decimal (e.g., 0.05e18 = 5%)
    /// @param timeWad Time in years in 18-decimal (e.g., 1e18 = 1 year)
    /// @return The final amount after interest (same decimals as principal)
    function continuousInterest(
        uint256 principal,
        int256 rateWad,
        int256 timeWad
    ) internal pure returns (uint256) {
        // YOUR CODE HERE
        // Step 1: compute rate × time
        // Step 2: compute e^(rate × time) using expWad
        // Step 3: multiply principal by the result

        uint256 exponent = FixedPointMathLib.mulDiv(
            uint256(rateWad),
            uint256(timeWad),
            1e18
        );

        int256 multiplier = FixedPointMathLib.expWad(int256(exponent));

        return Math.mulDiv(principal, uint256(multiplier), 1e18);
    }

    /// @notice Computes exponential decay (e.g., Dutch auction price)
    /// @param startAmount The starting value
    /// @param decayFactorWad The per-period multiplier in 18-decimal (e.g., 0.97e18 = 3% decay)
    /// @param periodsWad Number of periods in 18-decimal (e.g., 5e18 = 5 periods)
    /// @return The decayed amount
    function exponentialDecay(
        uint256 startAmount,
        int256 decayFactorWad,
        int256 periodsWad
    ) internal pure returns (uint256) {
        // YOUR CODE HERE
        // Step 1: compute decayFactor^periods using powWad
        // Step 2: multiply startAmount by the result

        int256 multiplier = FixedPointMathLib.powWad(
            decayFactorWad,
            periodsWad
        );

        return Math.mulDiv(startAmount, uint256(multiplier), 1e18);
    }
}
