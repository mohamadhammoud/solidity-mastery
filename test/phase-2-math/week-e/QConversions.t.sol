// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {QConversions} from "contracts/phase-2-math/week-e/QConversions.sol";

contract QConversionsTest is Test {
    function test_wad_one_to_q64() public pure {
        // 1.0 in wad = 1e18
        // 1.0 in Q64 = 2^64
        assertEq(QConversions.wadToQ64(1e18), 2 ** 64);
    }

    function test_q64_one_to_wad() public pure {
        // 1.0 in Q64 = 2^64
        // 1.0 in wad = 1e18
        assertEq(QConversions.q64ToWad(2 ** 64), 1e18);
    }

    function test_wad_half_to_q64() public pure {
        // 0.5 in wad = 0.5e18
        // 0.5 in Q64 = 2^63
        assertEq(QConversions.wadToQ64(0.5e18), 2 ** 63);
    }

    function test_q64_half_to_wad() public pure {
        assertEq(QConversions.q64ToWad(2 ** 63), 0.5e18);
    }

    function test_wad_two_to_q64() public pure {
        assertEq(QConversions.wadToQ64(2e18), 2 ** 65);
    }

    function test_wad_zero() public pure {
        assertEq(QConversions.wadToQ64(0), 0);
    }

    function test_q64_zero() public pure {
        assertEq(QConversions.q64ToWad(0), 0);
    }

    function test_roundtrip_loses_no_more_than_one_wei() public pure {
        uint256 original = 1.5e18;
        uint256 q64 = QConversions.wadToQ64(original);
        uint256 backToWad = QConversions.q64ToWad(q64);
        assertApproxEqAbs(backToWad, original, 1);
    }

    function testFuzz_roundtrip_never_gains_value(
        uint256 wadValue
    ) public pure {
        wadValue = bound(wadValue, 0, 1e36);
        uint256 q64 = QConversions.wadToQ64(wadValue);
        uint256 backToWad = QConversions.q64ToWad(q64);
        assertLe(backToWad, wadValue);
    }
}
