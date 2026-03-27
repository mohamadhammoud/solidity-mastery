// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {FixedPointLib} from "contracts/phase-2-math/week-b/FixedPointLib.sol";

contract RoundingTest is Test {
    function test_mulFP_rounds_down() public pure {
        // 1/3 in fixed point: mulFP(1e18, 0.333...e18)
        // Let's use: 1 * 3 / 1e18 = 0 (rounds down)
        assertEq(FixedPointLib.mulFP(1, 3), 0);
    }

    function test_mulFPUp_rounds_up() public pure {
        // Same calculation but rounds up to 1
        assertEq(FixedPointLib.mulFPUp(1, 3), 1);
    }

    function test_mulFPUp_exact_no_rounding() public pure {
        // 2.0 * 3.0 = 6.0 — exact, so both should match
        assertEq(FixedPointLib.mulFPUp(2e18, 3e18), 6e18);
        assertEq(FixedPointLib.mulFP(2e18, 3e18), 6e18);
    }

    function test_divFP_rounds_down() public pure {
        // 1.0 / 3.0 = 0.333...
        uint256 result = FixedPointLib.divFP(1e18, 3e18);
        assertEq(result, 333333333333333333); // last digit 3
    }

    function test_divFPUp_rounds_up() public pure {
        // 1.0 / 3.0 rounded up
        uint256 result = FixedPointLib.divFPUp(1e18, 3e18);
        assertEq(result, 333333333333333334); // last digit 4
    }

    function test_divFPUp_exact_no_rounding() public pure {
        // 6.0 / 3.0 = 2.0 — exact
        assertEq(FixedPointLib.divFPUp(6e18, 3e18), 2e18);
        assertEq(FixedPointLib.divFP(6e18, 3e18), 2e18);
    }

    function testFuzz_up_always_gte_down_mul(uint256 a, uint256 b) public pure {
        a = bound(a, 0, 1e38);
        b = bound(b, 0, 1e38);
        assertGe(FixedPointLib.mulFPUp(a, b), FixedPointLib.mulFP(a, b));
    }

    function testFuzz_up_always_gte_down_div(uint256 a, uint256 b) public pure {
        a = bound(a, 0, 1e50);
        b = bound(b, 1, 1e50);
        assertGe(FixedPointLib.divFPUp(a, b), FixedPointLib.divFP(a, b));
    }
}
