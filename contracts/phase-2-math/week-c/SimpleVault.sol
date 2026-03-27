// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@openzeppelin-contracts-5.2.0/utils/math/Math.sol";

contract SimpleVault {
    uint256 public totalAssets;
    uint256 public totalShares;
    mapping(address => uint256) public sharesOf;

    /// @notice Deposit assets and receive shares
    /// @param assets Amount of assets to deposit
    /// @return shares Amount of shares minted
    /// @dev Round DOWN shares to protect protocol
    function deposit(uint256 assets) external returns (uint256 shares) {
        // YOUR CODE HERE
        // 1. Compute shares to mint (handle first deposit case)
        // 2. Update totalAssets
        // 3. Update totalShares
        // 4. Update sharesOf[msg.sender]
        // 5. Return shares

        if (totalAssets == 0) {
            totalAssets = assets;
            totalShares = assets;
            sharesOf[msg.sender] = assets;

            return totalShares;
        } else {
            uint256 sharesToMint = Math.mulDiv(
                assets,
                totalShares,
                totalAssets
            );

            sharesOf[msg.sender] += sharesToMint;
            totalShares += sharesToMint;
            totalAssets += assets;

            return sharesToMint;
        }
    }

    /// @notice Burn shares and receive assets
    /// @param shares Amount of shares to burn
    /// @return assets Amount of assets returned
    /// @dev Round DOWN assets to protect protocol
    function withdraw(uint256 shares) external returns (uint256 assets) {
        // YOUR CODE HERE
        // 1. Compute assets to return
        // 2. Check user has enough shares
        // 3. Update sharesOf[msg.sender]
        // 4. Update totalShares
        // 5. Update totalAssets
        // 6. Return assets

        require(sharesOf[msg.sender] >= shares);

        uint256 assetsToBurn = Math.mulDiv(shares, totalAssets, totalShares);

        sharesOf[msg.sender] -= shares;
        totalShares -= shares;
        totalAssets -= assetsToBurn;

        return assetsToBurn;
    }

    /// @notice Simulates vault earning yield (for testing)
    /// @param amount Amount of assets earned
    function earn(uint256 amount) external {
        totalAssets += amount;
    }

    /// @notice Current share price in 18-decimal fixed point
    /// @return price The price of one share
    function sharePrice() external view returns (uint256) {
        // YOUR CODE HERE
        // Return 1e18 if no shares exist yet
        if (totalShares == 0) {
            return 1e18;
        }

        return Math.mulDiv(totalAssets, 1e18, totalShares);
    }
}
