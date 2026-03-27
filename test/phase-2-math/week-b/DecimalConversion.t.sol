// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {FixedPointLib} from "contracts/phase-2-math/week-b/FixedPointLib.sol";

contract DecimalConversionTest is Test {
    // --- convert tests ---

    function test_convert_18_to_6() public pure {
        // 1.0 token: 1e18 → 1e6
        assertEq(FixedPointLib.convert(1e18, 18, 6), 1e6);
    }

    function test_convert_6_to_18() public pure {
        // 1.0 token: 1e6 → 1e18
        assertEq(FixedPointLib.convert(1e6, 6, 18), 1e18);
    }

    function test_convert_8_to_18() public pure {
        // 1.0 WBTC: 1e8 → 1e18
        assertEq(FixedPointLib.convert(1e8, 8, 18), 1e18);
    }

    function test_convert_18_to_8() public pure {
        assertEq(FixedPointLib.convert(1e18, 18, 8), 1e8);
    }

    function test_convert_same_decimals() public pure {
        assertEq(FixedPointLib.convert(12345e18, 18, 18), 12345e18);
    }

    function test_convert_precision_loss() public pure {
        // 1 wei in 18 decimals converted to 6 decimals = 0 (too small)
        assertEq(FixedPointLib.convert(1, 18, 6), 0);
    }

    function test_convert_small_amount() public pure {
        // 1e12 wei in 18 decimals = 1 in 6 decimals (smallest that survives)
        assertEq(FixedPointLib.convert(1e12, 18, 6), 1);
    }

    // --- computeValue tests ---

    function test_eth_to_usdc() public pure {
        // 1.5 ETH at $2000 = 3000 USDC
        uint256 result = FixedPointLib.computeValue(1.5e18, 18, 2000e18, 6);
        assertEq(result, 3000e6);
    }

    function test_wbtc_to_usdc() public pure {
        // 0.5 WBTC at $60000 = 30000 USDC
        uint256 result = FixedPointLib.computeValue(0.5e8, 8, 60000e18, 6);
        assertEq(result, 30000e6);
    }

    function test_usdc_to_dai() public pure {
        // 100 USDC at $1 = 100 DAI
        uint256 result = FixedPointLib.computeValue(100e6, 6, 1e18, 18);
        assertEq(result, 100e18);
    }

    function test_eth_to_dai() public pure {
        // 2.0 ETH at $2000 = 4000 DAI (both 18 decimals)
        uint256 result = FixedPointLib.computeValue(2e18, 18, 2000e18, 18);
        assertEq(result, 4000e18);
    }

    function test_zero_amount() public pure {
        uint256 result = FixedPointLib.computeValue(0, 18, 2000e18, 6);
        assertEq(result, 0);
    }
}
