// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-d/PowDiv.sol";

contract PowDivTest is Test {
    function test_simple_square() public pure {
        assertEq(MathLib.powDiv(3, 2, 1), 9);
    }

    function test_simple_cube() public pure {
        assertEq(MathLib.powDiv(2, 3, 1), 8);
    }

    function test_power_zero() public pure {
        assertEq(MathLib.powDiv(5, 0, 1), 1);
    }

    function test_power_one() public pure {
        assertEq(MathLib.powDiv(10, 1, 2), 5);
    }

    function test_divide_result() public pure {
        assertEq(MathLib.powDiv(2, 10, 4), 256);
    }

    function test_rounds_down() public pure {
        assertEq(MathLib.powDiv(3, 3, 10), 2);
    }

    function test_one_to_any_power() public pure {
        assertEq(MathLib.powDiv(1, 1000, 1), 1);
    }

    function test_large_k() public pure {
        // 10^18 / 10^9 = 10^9
        assertEq(MathLib.powDiv(10, 18, 1e9), 1e9);
    }
}
