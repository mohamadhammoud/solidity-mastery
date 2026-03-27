// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {
    InterestCalculator
} from "contracts/phase-2-math/week-c/InterestCalculator.sol";

contract InterestCalculatorTest is Test {
    // --- Continuous Interest ---

    function test_zero_rate() public pure {
        // 0% interest for 1 year = principal unchanged
        uint256 result = InterestCalculator.continuousInterest(
            1000e18,
            0,
            1e18
        );
        assertEq(result, 1000e18);
    }

    function test_zero_time() public pure {
        // Any rate for 0 time = principal unchanged
        uint256 result = InterestCalculator.continuousInterest(
            1000e18,
            0.05e18,
            0
        );
        assertEq(result, 1000e18);
    }

    function test_5_percent_one_year() public pure {
        // 1000 at 5% for 1 year ≈ 1051.27
        uint256 result = InterestCalculator.continuousInterest(
            1000e18,
            0.05e18,
            1e18
        );
        // Allow 0.01 tolerance due to fixed-point precision
        assertApproxEqAbs(result, 1051.271096e18, 0.01e18);
    }

    function test_10_percent_two_years() public pure {
        // 500 at 10% for 2 years ≈ 610.70
        uint256 result = InterestCalculator.continuousInterest(
            500e18,
            0.1e18,
            2e18
        );
        assertApproxEqAbs(result, 610.70e18, 0.01e18);
    }

    function test_usdc_decimals() public pure {
        // Works with 6-decimal tokens too
        // 1000 USDC at 5% for 1 year
        uint256 result = InterestCalculator.continuousInterest(
            1000e6,
            0.05e18,
            1e18
        );
        assertApproxEqAbs(result, 1051.271096e6, 0.01e6);
    }

    // --- Exponential Decay ---

    function test_no_decay() public pure {
        // Factor 1.0, no decay
        uint256 result = InterestCalculator.exponentialDecay(10e18, 1e18, 5e18);
        assertEq(result, 10e18);
    }

    function test_3_percent_decay_5_periods() public pure {
        // 10 ETH, 3% decay per day, 5 days
        // 10 × 0.97^5 ≈ 8.587
        uint256 result = InterestCalculator.exponentialDecay(
            10e18,
            0.97e18,
            5e18
        );
        assertApproxEqAbs(result, 8.587340257e18, 0.01e18);
    }

    function test_zero_periods() public pure {
        // Zero periods = no decay
        uint256 result = InterestCalculator.exponentialDecay(10e18, 0.97e18, 0);
        assertEq(result, 10e18);
    }

    function test_50_percent_decay_one_period() public pure {
        // Half-life: 10 × 0.5^1 = 5
        // Half-life: 10 × 0.5^1 = 5
        uint256 result = InterestCalculator.exponentialDecay(
            10e18,
            0.5e18,
            1e18
        );
        assertApproxEqAbs(result, 5e18, 0.01e18);
    }
}
