// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-5/MathLib.sol";

contract AverageTest is Test {
    function test_simple_average() public pure {
        assertEq(MathLib.average(10, 20), 15);
    }

    function test_same_values() public pure {
        assertEq(MathLib.average(7, 7), 7);
    }

    function test_zero_and_zero() public pure {
        assertEq(MathLib.average(0, 0), 0);
    }

    function test_zero_and_one() public pure {
        assertEq(MathLib.average(0, 1), 0); // rounds down
    }

    function test_one_and_two() public pure {
        assertEq(MathLib.average(1, 2), 1); // rounds down
    }

    function test_both_max() public pure {
        // (max + max) / 2 = max
        assertEq(
            MathLib.average(type(uint256).max, type(uint256).max),
            type(uint256).max
        );
    }

    function test_max_and_one() public pure {
        // (max + 1) / 2 = 2^255
        assertEq(
            MathLib.average(type(uint256).max, 1),
            (type(uint256).max / 2) + 1
        );
    }

    function test_max_and_zero() public pure {
        assertEq(MathLib.average(type(uint256).max, 0), type(uint256).max / 2);
    }

    function test_max_and_max_minus_one() public pure {
        assertEq(
            MathLib.average(type(uint256).max, type(uint256).max - 1),
            type(uint256).max - 1
        );
    }

    function testFuzz_commutative(uint256 a, uint256 b) public pure {
        assertEq(MathLib.average(a, b), MathLib.average(b, a));
    }

    function testFuzz_result_between_inputs(uint256 a, uint256 b) public pure {
        uint256 lo = a < b ? a : b;
        uint256 hi = a > b ? a : b;
        uint256 avg = MathLib.average(a, b);
        assertGe(avg, lo);
        assertLe(avg, hi);
    }
}
