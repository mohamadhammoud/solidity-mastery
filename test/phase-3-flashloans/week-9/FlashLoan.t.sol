// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@forge-std/src/Test.sol";
import "contracts/phase-3-flashloans/week-9/MockERC20.sol";
import "contracts/phase-3-flashloans/week-9/FlashLender.sol";
import "contracts/phase-3-flashloans/week-9/FlashBorrower.sol";

/// @dev Approves repayment but returns wrong magic value
contract WrongReturnBorrower {
    function onFlashLoan(
        address,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata
    ) external returns (bytes32) {
        IERC20(token).approve(msg.sender, amount + fee);
        return keccak256("wrong.value");
    }
}

/// @dev Does not approve repayment at all
contract BadBorrower {
    bytes32 public constant CALLBACK_SUCCESS =
        keccak256("ERC3156FlashBorrower.onFlashLoan");

    function onFlashLoan(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external returns (bytes32) {
        return CALLBACK_SUCCESS;
    }
}

contract FlashLoanTest is Test {
    MockERC20 token;
    FlashLender lender;
    FlashBorrower borrower;

    uint256 constant LENDER_INITIAL = 1_000e18;
    uint256 constant BORROW_AMOUNT = 100e18;

    function setUp() public {
        token = new MockERC20();
        lender = new FlashLender(address(token));
        borrower = new FlashBorrower(address(lender));

        token.mint(address(lender), LENDER_INITIAL);
        token.mint(address(borrower), 1e18); // covers 0.1% fee on 100e18
    }

    // --- maxFlashLoan ---

    function test_maxFlashLoan_returnsFullBalance() public {
        assertEq(
            lender.maxFlashLoan(address(token)),
            LENDER_INITIAL,
            "should return lender balance for supported token"
        );
    }

    function test_maxFlashLoan_returnsZeroForUnsupportedToken() public {
        assertEq(
            lender.maxFlashLoan(address(0xdead)),
            0,
            "should return 0 for unsupported token"
        );
    }

    // --- flashFee ---

    function test_flashFee_correctAmount() public {
        uint256 fee = lender.flashFee(address(token), BORROW_AMOUNT);
        assertEq(fee, 0.1e18, "fee should be 0.1% of borrow amount");
    }

    function test_flashFee_revertsOnUnsupportedToken() public {
        vm.expectRevert();
        lender.flashFee(address(0xdead), BORROW_AMOUNT);
    }

    // --- flashLoan happy path ---

    function test_flashLoan_succeeds() public {
        uint256 fee = lender.flashFee(address(token), BORROW_AMOUNT);

        borrower.initiateLoan(address(token), BORROW_AMOUNT);

        assertEq(
            token.balanceOf(address(lender)),
            LENDER_INITIAL + fee,
            "lender balance should increase by fee"
        );
        assertEq(
            token.balanceOf(address(borrower)),
            1e18 - fee,
            "borrower balance should decrease by fee"
        );
    }

    function test_flashLoan_returnsTrue() public {
        bool result = lender.flashLoan(
            IERC3156FlashBorrower(address(borrower)),
            address(token),
            BORROW_AMOUNT,
            ""
        );
        assertTrue(result);
    }

    // --- flashLoan failure cases ---

    function test_flashLoan_revertsIfNotRepaid() public {
        BadBorrower bad = new BadBorrower();
        vm.expectRevert();
        lender.flashLoan(
            IERC3156FlashBorrower(address(bad)),
            address(token),
            BORROW_AMOUNT,
            ""
        );
    }

    function test_flashLoan_revertsIfWrongReturnValue() public {
        WrongReturnBorrower bad = new WrongReturnBorrower();
        token.mint(address(bad), 1e18);
        vm.expectRevert();
        lender.flashLoan(
            IERC3156FlashBorrower(address(bad)),
            address(token),
            BORROW_AMOUNT,
            ""
        );
    }

    function test_flashLoan_revertsOnUnsupportedToken() public {
        vm.expectRevert();
        lender.flashLoan(
            IERC3156FlashBorrower(address(borrower)),
            address(0xdead),
            BORROW_AMOUNT,
            ""
        );
    }

    function test_onFlashLoan_revertsIfCallerIsNotLender() public {
        vm.prank(address(0xdead));
        vm.expectRevert();
        borrower.onFlashLoan(
            address(this),
            address(token),
            BORROW_AMOUNT,
            0,
            ""
        );
    }

    // --- fuzz ---

    function test_fuzz_flashFee(uint256 amount) public {
        amount = bound(amount, 0, type(uint128).max);
        uint256 fee = lender.flashFee(address(token), amount);
        assertEq(fee, (amount * 10) / 10_000, "fee formula broken");
    }
}
