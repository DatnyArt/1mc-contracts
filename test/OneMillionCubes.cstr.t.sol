// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesConstructor is OneMillionCubesCore {
    function testConstructorSetsOwner() public view {
        assertEq(cubes.owner(), address(this));
    }

    function testConstructorSetsAdminSigner() public view {
        assertEq(cubes.adminSigner(), adminSigner);
    }

    // Game Config Tests
    function testConstructorSetsFee() public view {
        (uint256 fee, , , , ) = cubes.gameConfig();
        assertEq(fee, FEE);
    }

    function testConstructorSetsMinDiscElemNumb() public view {
        ( , uint256 minDiscElemNumb, , , ) = cubes.gameConfig();
        assertEq(minDiscElemNumb, MIN_DISC_ELEM_NUMB);
    }

    function testConstructorSetsBlockNumber() public view {
        ( , , uint256 blockNumber, , ) = cubes.gameConfig();
        assertEq(blockNumber, block.number + 1000);
    }

    function testConstructorSetsTotalElemNumb() public view {
        ( , , , uint256 totalElemNumb, ) = cubes.gameConfig();
        assertEq(totalElemNumb, TOTAL_ELEM_NUMB);
    }

    function testConstructorSetsMaxSelectionsPerTx() public view {
        ( , , , , uint256 maxSelectionsPerTx) = cubes.gameConfig();
        assertEq(maxSelectionsPerTx, MAX_SELECTIONS_PER_TX);
    }

    // Reward Parameters Tests
    function testConstructorSetsSingleGoldReward() public view {
        (uint256 singleGoldReward, , , , , , , , , ) = cubes.rewardParameters();
        assertEq(singleGoldReward, SINGLE_GOLD_REWARD);
    }

    function testConstructorSetsNumOfGoldRewards() public view {
        ( , uint256 numOfGoldRewards, , , , , , , , ) = cubes.rewardParameters();
        assertEq(numOfGoldRewards, NUM_OF_GOLD_REWARDS);
    }

    function testConstructorSetsSingleSilverReward() public view {
        ( , , uint256 singleSilverReward, , , , , , , ) = cubes.rewardParameters();
        assertEq(singleSilverReward, SINGLE_SILVER_REWARD);
    }

    function testConstructorSetsNumOfSilverRewards() public view {
        ( , , , uint256 numOfSilverRewards, , , , , , ) = cubes.rewardParameters();
        assertEq(numOfSilverRewards, NUM_OF_SILVER_REWARDS);
    }

    function testConstructorSetsSingleBronzeReward() public view {
        ( , , , , uint256 singleBronzeReward, , , , , ) = cubes.rewardParameters();
        assertEq(singleBronzeReward, SINGLE_BRONZE_REWARD);
    }

    function testConstructorSetsNumOfBronzeRewards() public view {
        ( , , , , , uint256 numOfBronzeRewards, , , , ) = cubes.rewardParameters();
        assertEq(numOfBronzeRewards, NUM_OF_BRONZE_REWARDS);
    }

    function testConstructorSetsSinglePlatinumReward() public view {
        ( , , , , , , uint256 singlePlatinumReward, , , ) = cubes.rewardParameters();
        assertEq(singlePlatinumReward, SINGLE_PLATINUM_REWARD);
    }

    function testConstructorSetsNumOfPlatinumRewards() public view {
        ( , , , , , , , uint256 numOfPlatinumRewards, , ) = cubes.rewardParameters();
        assertEq(numOfPlatinumRewards, NUM_OF_PLATINUM_REWARDS);
    }

    function testConstructorSetsSingleDiamondReward() public view {
        ( , , , , , , , , uint256 singleDiamondReward, ) = cubes.rewardParameters();
        assertEq(singleDiamondReward, SINGLE_DIAMOND_REWARD);
    }

    function testConstructorSetsNumOfDiamondRewards() public view {
        ( , , , , , , , , , uint256 numOfDiamondRewards) = cubes.rewardParameters();
        assertEq(numOfDiamondRewards, NUM_OF_DIAMOND_REWARDS);
    }

    function testConstructorSetsTotalAllowedCubes() public view {
        assertEq(
            cubes.totalAllowedCubes(),
            NUM_OF_GOLD_REWARDS + 
            NUM_OF_SILVER_REWARDS + 
            NUM_OF_BRONZE_REWARDS + 
            NUM_OF_PLATINUM_REWARDS + 
            NUM_OF_DIAMOND_REWARDS
        );
    }

    function testConstructorSetsTotalSelections() public view {
        assertEq(cubes.totalSelections(), 0);
    }
}
