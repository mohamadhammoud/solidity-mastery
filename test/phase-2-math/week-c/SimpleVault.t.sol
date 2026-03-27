// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "@forge-std/src/Test.sol";
import {SimpleVault} from "contracts/phase-2-math/week-c/SimpleVault.sol";

contract SimpleVaultTest is Test {
    SimpleVault vault;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        vault = new SimpleVault();
    }

    function test_first_deposit() public {
        vm.prank(alice);
        uint256 shares = vault.deposit(1000e18);
        assertEq(shares, 1000e18);
        assertEq(vault.totalAssets(), 1000e18);
        assertEq(vault.totalShares(), 1000e18);
        assertEq(vault.sharesOf(alice), 1000e18);
    }

    function test_second_deposit_same_price() public {
        vm.prank(alice);
        vault.deposit(1000e18);

        vm.prank(bob);
        uint256 shares = vault.deposit(500e18);
        assertEq(shares, 500e18); // same 1:1 ratio
    }

    function test_deposit_after_yield() public {
        // Alice deposits 1000
        vm.prank(alice);
        vault.deposit(1000e18);

        // Vault earns 1000 (share price doubles to 2.0)
        vault.earn(1000e18);

        // Bob deposits 1000 — should get 500 shares (1000 / 2.0)
        vm.prank(bob);
        uint256 shares = vault.deposit(1000e18);
        assertEq(shares, 500e18);
    }

    function test_withdraw_all() public {
        vm.prank(alice);
        vault.deposit(1000e18);

        vm.prank(alice);
        uint256 assets = vault.withdraw(1000e18);
        assertEq(assets, 1000e18);
        assertEq(vault.sharesOf(alice), 0);
        assertEq(vault.totalAssets(), 0);
        assertEq(vault.totalShares(), 0);
    }

    function test_withdraw_after_yield() public {
        // Alice deposits 1000
        vm.prank(alice);
        vault.deposit(1000e18);

        // Vault earns 500
        vault.earn(500e18);

        // Alice withdraws all — should get 1500
        vm.prank(alice);
        uint256 assets = vault.withdraw(1000e18);
        assertEq(assets, 1500e18);
    }

    function test_two_depositors_fair_share() public {
        // Alice deposits 1000
        vm.prank(alice);
        vault.deposit(1000e18);

        // Bob deposits 500
        vm.prank(bob);
        vault.deposit(500e18);

        // Vault earns 300 (total now 1800)
        vault.earn(300e18);

        // Alice has 1000 shares out of 1500 total = 2/3
        // Alice should get 2/3 of 1800 = 1200
        vm.prank(alice);
        uint256 aliceAssets = vault.withdraw(1000e18);
        assertEq(aliceAssets, 1200e18);

        // Bob has 500 shares out of remaining 500 total
        // Bob should get all remaining = 600
        vm.prank(bob);
        uint256 bobAssets = vault.withdraw(500e18);
        assertEq(bobAssets, 600e18);
    }

    function test_share_price_initial() public view {
        assertEq(vault.sharePrice(), 1e18);
    }

    function test_share_price_after_yield() public {
        vm.prank(alice);
        vault.deposit(1000e18);

        vault.earn(1000e18);

        // 2000 assets / 1000 shares = 2.0
        assertEq(vault.sharePrice(), 2e18);
    }

    function test_cannot_withdraw_more_than_balance() public {
        vm.prank(alice);
        vault.deposit(1000e18);

        vm.prank(alice);
        vm.expectRevert();
        vault.withdraw(2000e18);
    }
}
