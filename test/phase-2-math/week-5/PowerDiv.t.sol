// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-5/MathLib.sol";

contract PowDivTest is Test {
    // function test_simple_square() public pure {
    //     // 3^2 / 1 = 9
    //     assertEq(MathLib.powDiv(3, 2, 1), 9);
    // }
    // function test_simple_cube() public pure {
    //     // 2^3 / 1 = 8
    //     assertEq(MathLib.powDiv(2, 3, 1), 8);
    // }
    // function test_power_zero() public pure {
    //     // x^0 / k = 1 / k
    //     assertEq(MathLib.powDiv(5, 0, 1), 1);
    // }
    // function test_power_one() public pure {
    //     // 10^1 / 2 = 5
    //     assertEq(MathLib.powDiv(10, 1, 2), 5);
    // }
    // function test_divide_result() public pure {
    //     // 2^10 / 4 = 1024 / 4 = 256
    //     assertEq(MathLib.powDiv(2, 10, 4), 256);
    // }
    // function test_large_power_with_divisor() public pure {
    //     // 10^18 / 10^9 = 10^9 = 1_000_000_000
    //     assertEq(MathLib.powDiv(10, 18, 1e9), 1e9);
    // }
    // function test_rounds_down() public pure {
    //     // 3^3 / 10 = 27 / 10 = 2 (rounded down)
    //     assertEq(MathLib.powDiv(3, 3, 10), 2);
    // }
    // function test_intermediate_overflow() public pure {
    //     // 2^200 * 2^200 = 2^400 overflows, but 2^200 / 2^200 = 1
    //     // (2^100)^4 / (2^200) — tests that intermediate overflow is handled
    //     uint256 x = 2 ** 100;
    //     uint256 result = MathLib.powDiv(x, 4, x ** 2);
    //     assertEq(result, x ** 2);
    // }
    // function test_power_of_two() public pure {
    //     // 2^255 / 2^200 = 2^55
    //     assertEq(MathLib.powDiv(2, 255, 2 ** 200), 2 ** 55);
    // }
    // function test_one_to_any_power() public pure {
    //     // 1^1000 / 1 = 1
    //     assertEq(MathLib.powDiv(1, 1000, 1), 1);
    // }
    // function test_large_base_small_power() public pure {
    //     // (10^50)^2 / (10^50) = 10^50
    //     uint256 base = 10 ** 50;
    //     assertEq(MathLib.powDiv(base, 2, base), base);
    // }
}
