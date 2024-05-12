pragma solidity ^0.8.0;

import "./NFTMarketplace.sol";

contract NFTMarketplaceReward {

    // Reference to the NFTMarketplace contract
    NFTMarketplace private marketplace;

    // Mapping to keep track of the number of NFTs sold by each seller
    mapping(address => uint256) private sellerNFTCount;

    // Event to log the reward given to a seller
    event SellerRewarded(address indexed seller, uint256 reward);

    // Constructor to set the marketplace contract address
    constructor(NFTMarketplace _marketplace) {
        marketplace = _marketplace;
    }

    // Function to check if a seller has sold 10 NFTs and reward them
    function checkAndReward(address seller) external {
        uint256 nftCount = marketplace.getSoldNFTsForAddress(seller).length;
        uint256 currentCount = sellerNFTCount[seller];
        
        // Check if the seller has sold at least 10 more NFTs
        if (nftCount / 10 > currentCount / 10) {
            // Calculate the number of rewards to give
            uint256 rewards = (nftCount / 10 - currentCount / 10) * 10;
            // Increment the seller's NFT count
            sellerNFTCount[seller] = nftCount;
            // Transfer the reward to the seller
            payable(seller).transfer(rewards * marketplace.getListPrice());
            // Emit an event
            emit SellerRewarded(seller, rewards * marketplace.getListPrice());
        }
    }
}
