// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {FixedPointMathLib} from "solady/utils/FixedPointMathLib.sol";
import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

library InterestAccrual {
    uint256 constant WAD = 1e18;
    uint256 constant SECONDS_PER_YEAR = 365.25 days;

    /// @notice Converts annual rate to per-second rate
    /// @param annualRateWad Annual rate in 18-decimal (e.g., 0.05e18 = 5%)
    /// @return Per-second rate in 18-decimal
    function annualToPerSecond(
        uint256 annualRateWad
    ) internal pure returns (uint256) {
        // YOUR CODE HERE

        return annualRateWad / SECONDS_PER_YEAR;
    }

    /// @notice Computes new share price after interest accrual
    /// @param currentPrice Current share price in 18-decimal
    /// @param annualRateWad Annual interest rate in 18-decimal
    /// @param timeElapsed Seconds since last update
    /// @return New share price in 18-decimal
    /// @dev Uses continuous compounding: newPrice = currentPrice × e^(rate × time)
    function accrueInterest(
        uint256 currentPrice,
        uint256 annualRateWad,
        uint256 timeElapsed
    ) internal pure returns (uint256) {
        // YOUR CODE HERE
        // 1. Compute exponent = annualRate × timeElapsed / SECONDS_PER_YEAR
        // 2. Compute multiplier = e^exponent using expWad
        // 3. Return currentPrice × multiplier / 1e18

        // Step 1: exponent = annualRate × timeElapsed / SECONDS_PER_YEAR
        uint256 exponent = Math.mulDiv(
            annualRateWad,
            timeElapsed,
            SECONDS_PER_YEAR
        );

        // Step 2: multiplier = e^exponent
        int256 multiplier = FixedPointMathLib.expWad(int256(exponent));

        // Step 3: newPrice = currentPrice × multiplier / 1e18
        return Math.mulDiv(currentPrice, uint256(multiplier), WAD);
    }
}
