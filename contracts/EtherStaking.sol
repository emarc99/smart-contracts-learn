// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherStaking {
    struct Stake {
        uint amount;
        uint stakingTime;
    }

    mapping(address => Stake) public stakes;
    // 300% APY (Annual Percentage Yield)
    uint public rewardRate = 300; 
    uint public secondsInYear = 365 days;

    // Custom errors for better gas efficiency
    error NoEtherStaked();
    error StakingPeriodTooShort();
    error InvalidWithdrawalTime();
    error NoStakingBefore15Days();

    event Staked(address indexed user, uint amount, uint timestamp);
    event Withdrawn(address indexed user, uint amount, uint reward, uint timestamp);

    // Stake Ether into the contract
    function stakeEther() public payable {
        require(msg.value > 0, "You need to stake some Ether");

        // If the user already has staked Ether, calculate the previous rewards and update the stake
        if (stakes[msg.sender].amount > 0) {
            uint reward = calculateReward(msg.sender);
            stakes[msg.sender].amount += reward; 
        }

        stakes[msg.sender].amount += msg.value;
        stakes[msg.sender].stakingTime = block.timestamp;

        emit Staked(msg.sender, msg.value, block.timestamp);
    }

    // Withdraw staked Ether and earned rewards
    function withdrawEther(uint timePeriod) public {
        Stake memory userStake = stakes[msg.sender];
        if (userStake.amount == 0) revert NoEtherStaked();

        // Time thresholds: 15 days, 1 month, 6 months, 1 year
        uint stakingDuration = block.timestamp - userStake.stakingTime;

        // Custom error for early withdrawal
        if (stakingDuration < 15 days) revert NoStakingBefore15Days(); 

        if (timePeriod == 15 days) {
            if (stakingDuration < 15 days) revert InvalidWithdrawalTime();
        } else if (timePeriod == 30 days) {
            if (stakingDuration < 30 days) revert InvalidWithdrawalTime();
        } else if (timePeriod == 180 days) {
            if (stakingDuration < 180 days) revert InvalidWithdrawalTime();
        } else if (timePeriod == 365 days) {
            if (stakingDuration < 365 days) revert InvalidWithdrawalTime();
        } else {

        // For any other invalid timePeriod
            revert InvalidWithdrawalTime(); 
        }

        uint reward = calculateReward(msg.sender);
        uint totalAmount = userStake.amount + reward;

        // Reset the user's stake before transferring funds
        stakes[msg.sender].amount = 0;
        stakes[msg.sender].stakingTime = 0;

        // Transfer the staked Ether and the reward to the user
        payable(msg.sender).transfer(totalAmount);

        emit Withdrawn(msg.sender, userStake.amount, reward, block.timestamp);
    }

    // Calculate the reward based on staking time
    function calculateReward(address user) public view returns (uint) {
        Stake memory userStake = stakes[user];
        uint stakingDuration = block.timestamp - userStake.stakingTime;

        // Apply 300% APY prorated by time period
        // Annual interest: amount * (1 + 3 * (duration/secondsInYear))
        uint interest = (userStake.amount * rewardRate * stakingDuration) / (100 * secondsInYear);
        return interest;
    }

    // Fallback function to prevent Ether from being sent to the contract without staking
    receive() external payable {
        revert("Send Ether using the stakeEther function");
    }
}
