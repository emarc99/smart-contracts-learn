// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CircleAreaCalculator {

    uint256 pi = 314159;

    // Function to calculate the area of a circle given its radius
    function calculateArea(uint256 radius) public view returns (uint256) {
        uint256 area = (pi * radius * radius)/ 100000;
        return area;
    }
}
