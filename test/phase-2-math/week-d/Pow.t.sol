// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-d/Pow.sol";

contract PowTest is Test {
    function test_anything_to_zero() public pure {
        assertEq(MathLib.pow(5, 0), 1);
    }

    function test_anything_to_one() public pure {
        assertEq(MathLib.pow(7, 1), 7);
    }

    function test_two_squared() public pure {
        assertEq(MathLib.pow(2, 2), 4);
    }

    function test_two_cubed() public pure {
        assertEq(MathLib.pow(2, 3), 8);
    }

    function test_two_to_five() public pure {
        assertEq(MathLib.pow(2, 5), 32);
    }

    function test_three_to_six() public pure {
        assertEq(MathLib.pow(3, 6), 729);
    }

    function test_two_to_ten() public pure {
        assertEq(MathLib.pow(2, 10), 1024);
    }

    function test_ten_to_eighteen() public pure {
        assertEq(MathLib.pow(10, 18), 1e18);
    }

    function test_one_to_anything() public pure {
        assertEq(MathLib.pow(1, 1000), 1);
    }

    function test_zero_to_anything() public pure {
        assertEq(MathLib.pow(0, 100), 0);
    }

    function test_zero_to_zero() public pure {
        assertEq(MathLib.pow(0, 0), 1);
    }
}
