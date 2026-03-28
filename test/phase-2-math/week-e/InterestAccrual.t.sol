// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {
    InterestAccrual
} from "contracts/phase-2-math/week-e/InterestAccrual.sol";

contract InterestAccrualTest is Test {
    function test_annual_to_per_second() public pure {
        uint256 perSecond = InterestAccrual.annualToPerSecond(0.05e18);
        assertApproxEqAbs(perSecond, 1584404390, 10);
    }

    function test_zero_time_no_change() public pure {
        uint256 newPrice = InterestAccrual.accrueInterest(1e18, 0.05e18, 0);
        assertEq(newPrice, 1e18);
    }

    function test_zero_rate_no_change() public pure {
        uint256 newPrice = InterestAccrual.accrueInterest(1e18, 0, 86400);
        assertEq(newPrice, 1e18);
    }

    function test_one_year_5_percent() public pure {
        // 1.0 share price, 5% annual, 1 year
        uint256 newPrice = InterestAccrual.accrueInterest(
            1e18,
            0.05e18,
            365.25 days
        );
        // e^0.05 ≈ 1.05127
        assertApproxEqAbs(newPrice, 1.05127e18, 0.001e18);
    }

    function test_one_day_5_percent() public pure {
        // 1.0 share price, 5% annual, 1 day
        uint256 newPrice = InterestAccrual.accrueInterest(
            1e18,
            0.05e18,
            1 days
        );
        // Should be slightly above 1.0
        assertGt(newPrice, 1e18);
        assertLt(newPrice, 1.001e18);
    }

    function test_high_rate_one_year() public pure {
        // 100% annual for 1 year: e^1 ≈ 2.71828
        uint256 newPrice = InterestAccrual.accrueInterest(
            1e18,
            1e18,
            365.25 days
        );
        assertApproxEqAbs(newPrice, 2.71828e18, 0.001e18);
    }

    function test_share_price_doubles() public pure {
        // At what rate does share price double in 1 year?
        // e^r = 2 → r = ln(2) ≈ 0.6931
        uint256 newPrice = InterestAccrual.accrueInterest(
            1e18,
            0.6931e18,
            365.25 days
        );
        assertApproxEqAbs(newPrice, 2e18, 0.001e18);
    }

    function test_existing_share_price() public pure {
        // Start at 2.0 share price, 10% for 1 year
        uint256 newPrice = InterestAccrual.accrueInterest(
            2e18,
            0.1e18,
            365.25 days
        );
        // 2.0 × e^0.1 ≈ 2.0 × 1.10517 ≈ 2.21034
        assertApproxEqAbs(newPrice, 2.21034e18, 0.001e18);
    }
}
