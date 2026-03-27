// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {FixedPointLib} from "contracts/phase-2-math/week-b/FixedPointLib.sol";

contract FixedPointLibTest is Test {
    function test_mul_whole_numbers() public pure {
        // 2.0 * 3.0 = 6.0
        assertEq(FixedPointLib.mulFP(2e18, 3e18), 6e18);
    }

    function test_mul_with_decimals() public pure {
        // 1.5 * 2.0 = 3.0
        assertEq(FixedPointLib.mulFP(1.5e18, 2e18), 3e18);
    }

    function test_mul_both_decimals() public pure {
        // 0.5 * 0.5 = 0.25
        assertEq(FixedPointLib.mulFP(0.5e18, 0.5e18), 0.25e18);
    }

    function test_mul_by_zero() public pure {
        assertEq(FixedPointLib.mulFP(5e18, 0), 0);
    }

    function test_mul_by_one() public pure {
        // 7.0 * 1.0 = 7.0
        assertEq(FixedPointLib.mulFP(7e18, 1e18), 7e18);
    }

    function test_div_whole_numbers() public pure {
        // 6.0 / 3.0 = 2.0
        assertEq(FixedPointLib.divFP(6e18, 3e18), 2e18);
    }

    function test_div_with_decimals() public pure {
        // 3.0 / 2.0 = 1.5
        assertEq(FixedPointLib.divFP(3e18, 2e18), 1.5e18);
    }

    function test_div_less_than_one() public pure {
        // 1.0 / 4.0 = 0.25
        assertEq(FixedPointLib.divFP(1e18, 4e18), 0.25e18);
    }

    function test_div_by_one() public pure {
        // 5.0 / 1.0 = 5.0
        assertEq(FixedPointLib.divFP(5e18, 1e18), 5e18);
    }

    function test_mul_then_div_roundtrip() public pure {
        // (3.0 * 2.0) / 2.0 should give back 3.0
        uint256 product = FixedPointLib.mulFP(3e18, 2e18);
        uint256 result = FixedPointLib.divFP(product, 2e18);
        assertEq(result, 3e18);
    }

    function test_interest_calculation() public pure {
        // 100 tokens at 5.25% interest
        // 100.0 * 0.0525 = 5.25
        uint256 principal = 100e18;
        uint256 rate = 0.0525e18;
        uint256 interest = FixedPointLib.mulFP(principal, rate);
        assertEq(interest, 5.25e18);
    }
}
