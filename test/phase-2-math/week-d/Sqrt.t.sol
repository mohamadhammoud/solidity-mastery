// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-d/Sqrt.sol";

contract SqrtTest is Test {
    function test_sqrt_zero() public pure {
        assertEq(MathLib.sqrt(0), 0);
    }

    function test_sqrt_one() public pure {
        assertEq(MathLib.sqrt(1), 1);
    }

    function test_sqrt_four() public pure {
        assertEq(MathLib.sqrt(4), 2);
    }

    function test_sqrt_nine() public pure {
        assertEq(MathLib.sqrt(9), 3);
    }

    function test_sqrt_twenty_five() public pure {
        assertEq(MathLib.sqrt(25), 5);
    }

    function test_sqrt_rounds_down() public pure {
        // sqrt(10) = 3 because 3²=9 ≤ 10 < 16=4²
        assertEq(MathLib.sqrt(10), 3);
    }

    function test_sqrt_two() public pure {
        assertEq(MathLib.sqrt(2), 1);
    }

    function test_sqrt_large_perfect_square() public pure {
        // 1000000² = 1e12
        assertEq(MathLib.sqrt(1e12), 1e6);
    }

    function test_sqrt_max_uint() public pure {
        // sqrt(type(uint256).max) should not revert
        uint256 result = MathLib.sqrt(type(uint256).max);
        // result² ≤ max < (result+1)²
        assertLe(result * result, type(uint256).max);
    }

    function testFuzz_sqrt_squared_le_input(uint256 n) public pure {
        uint256 r = MathLib.sqrt(n);
        assertLe(r * r, n);
    }

    function testFuzz_sqrt_next_squared_gt_input(uint256 n) public pure {
        n = bound(n, 0, type(uint256).max - 2);
        uint256 r = MathLib.sqrt(n);
        if (r < type(uint128).max) {
            assertGt((r + 1) * (r + 1), n);
        }
    }
}
