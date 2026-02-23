// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {MathLib} from "contracts/phase-2-math/week-5/DivUp.sol";

contract DivUpWrapper {
    function divUp(uint256 a, uint256 b) external pure returns (uint256) {
        return MathLib.divUp(a, b);
    }
}

contract DivUpTest is Test {
    DivUpWrapper wrapper;

    function setUp() public {
        wrapper = new DivUpWrapper();
    }

    function test_divUp_zero_numerator() public pure {
        assertEq(MathLib.divUp(0, 5), 0);
    }

    function test_divUp_one_by_one() public pure {
        assertEq(MathLib.divUp(1, 1), 1);
    }

    function test_divUp_exact_division() public pure {
        assertEq(MathLib.divUp(4, 2), 2);
    }

    function test_divUp_rounds_up() public pure {
        assertEq(MathLib.divUp(5, 2), 3);
    }

    function test_divUp_rounds_up_thirds() public pure {
        assertEq(MathLib.divUp(7, 3), 3);
    }

    function test_divUp_large_denominator() public pure {
        assertEq(MathLib.divUp(100, 51), 2);
    }

    function test_divUp_reverts_on_zero_denominator() public {
        vm.expectRevert();
        wrapper.divUp(2, 0);
    }

    function test_divUp_zero_numerator_zero_denominator_reverts() public {
        vm.expectRevert();
        wrapper.divUp(0, 0);
    }

    function test_divUp_max_uint256() public pure {
        assertEq(MathLib.divUp(type(uint256).max, 1), type(uint256).max);
    }

    function test_divUp_max_uint256_by_two() public pure {
        assertEq(
            MathLib.divUp(type(uint256).max, 2),
            (type(uint256).max / 2) + 1
        );
    }

    function test_divUp_one_by_max() public pure {
        assertEq(MathLib.divUp(1, type(uint256).max), 1);
    }

    function testFuzz_divUp_never_less_than_regular_div(
        uint256 a,
        uint256 b
    ) public pure {
        b = bound(b, 1, type(uint256).max);
        uint256 regularDiv = a / b;
        uint256 ceilDiv = MathLib.divUp(a, b);
        assertGe(ceilDiv, regularDiv);
    }

    function testFuzz_divUp_exact_division_matches(
        uint256 b,
        uint256 k
    ) public pure {
        b = bound(b, 1, type(uint128).max);
        k = bound(k, 1, type(uint128).max);
        uint256 a = b * k;
        assertEq(MathLib.divUp(a, b), k);
    }
}
