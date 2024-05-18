//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./NFTMarketplace.sol";

contract NFTMarketplaceReward {

    //address payable owner;
    uint256 ceva;

    constructor() public {
        ceva = 3;
    }

    mapping(address => uint256) private sellerNFTCount;

    function increaseSellerNFTCount(address seller) public {
        sellerNFTCount[seller]++;
    }

    function checkReward(address seller) public view returns (uint256) {
        return sellerNFTCount[seller];
    }


    function calculateReward() internal pure returns (uint256) {
        return 0.01 ether; 
    }
}
