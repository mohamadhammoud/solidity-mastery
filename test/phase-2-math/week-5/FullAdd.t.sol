// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-5/FullAdd.sol";

contract FullAddTest is Test {
    function test_normal_addition() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(200, 50);
        assertEq(result, 250);
        assertFalse(overflow);
    }

    function test_add_zero() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(1000, 0);
        assertEq(result, 1000);
        assertFalse(overflow);
    }

    function test_both_zero() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(0, 0);
        assertEq(result, 0);
        assertFalse(overflow);
    }

    function test_exact_max() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(type(uint256).max, 0);
        assertEq(result, type(uint256).max);
        assertFalse(overflow);
    }

    function test_overflow_by_one() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(type(uint256).max, 1);
        assertEq(result, 0);
        assertTrue(overflow);
    }

    function test_overflow_by_two() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(type(uint256).max, 2);
        assertEq(result, 1);
        assertTrue(overflow);
    }

    function test_overflow_by_hundred() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(
            type(uint256).max,
            100
        );
        assertEq(result, 99);
        assertTrue(overflow);
    }

    function test_both_large() public pure {
        (uint256 result, bool overflow) = MathLib.fullAdd(
            type(uint256).max,
            type(uint256).max
        );
        assertEq(result, type(uint256).max - 1);
        assertTrue(overflow);
    }

    function test_half_max_no_overflow() public pure {
        uint256 half = type(uint256).max / 2;
        (uint256 result, bool overflow) = MathLib.fullAdd(half, half);
        assertEq(result, half * 2);
        assertFalse(overflow);
    }

    function testFuzz_no_overflow_when_sum_fits(
        uint256 a,
        uint256 b
    ) public pure {
        b = bound(b, 0, type(uint256).max - a);
        (uint256 result, bool overflow) = MathLib.fullAdd(a, b);
        assertEq(result, a + b);
        assertFalse(overflow);
    }

    function testFuzz_commutative(uint256 a, uint256 b) public pure {
        (uint256 result1, bool overflow1) = MathLib.fullAdd(a, b);
        (uint256 result2, bool overflow2) = MathLib.fullAdd(b, a);
        assertEq(result1, result2);
        assertEq(overflow1, overflow2);
    }
}
