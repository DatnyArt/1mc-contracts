// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std-1.9.2/src/Test.sol";
import "../src/OneMillionCubes.sol";

abstract contract OneMillionCubesCore is Test {
    OneMillionCubes public cubes;
    address public owner;
    address public adminSigner;
    address public user1;
    address public user2;
    address public ref1;
    address public ref2;
    address public address0;

    uint256 constant FEE = 0.0016 ether;
    uint256 constant MIN_DISC_ELEM_NUMB = 8000;
    uint256 constant TOTAL_ELEM_NUMB = 10000;
    uint256 constant MAX_SELECTIONS_PER_TX = 5;
    uint256 constant SINGLE_GOLD_REWARD = 315 ether;
    uint256 constant NUM_OF_GOLD_REWARDS = 3;
    uint256 constant SINGLE_SILVER_REWARD = 0.16 ether;
    uint256 constant NUM_OF_SILVER_REWARDS = 50;
    uint256 constant SINGLE_BRONZE_REWARD = 0.0315 ether;
    uint256 constant NUM_OF_BRONZE_REWARDS = 100;
    uint256 constant SINGLE_PLATINUM_REWARD = 0.016 ether;
    uint256 constant NUM_OF_PLATINUM_REWARDS = 500;
    uint256 constant SINGLE_DIAMOND_REWARD = 0.01 ether;
    uint256 constant NUM_OF_DIAMOND_REWARDS = 1000;

    function setUp() public virtual {
        owner = address(this);
        adminSigner = makeAddr("adminSigner");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        ref1 = makeAddr("referrer1");
        ref2 = makeAddr("referrer2");
        address0 = address(0);

        // Create game configuration parameters
        OneMillionCubes.GameConfig memory gameConfig = OneMillionCubes.GameConfig({
            fee: FEE,
            minDiscElemNumb: MIN_DISC_ELEM_NUMB,
            blockTimestamp: block.timestamp + 1000,
            totalElemNumb: TOTAL_ELEM_NUMB,
            maxSelectionsPerTx: MAX_SELECTIONS_PER_TX
        });

        // Create reward parameters
        OneMillionCubes.RewardParameters memory rewardParams = OneMillionCubes.RewardParameters({
            singleGoldReward: SINGLE_GOLD_REWARD,
            numOfGoldRewards: NUM_OF_GOLD_REWARDS,
            singleSilverReward: SINGLE_SILVER_REWARD,
            numOfSilverRewards: NUM_OF_SILVER_REWARDS,
            singleBronzeReward: SINGLE_BRONZE_REWARD,
            numOfBronzeRewards: NUM_OF_BRONZE_REWARDS,
            singlePlatinumReward: SINGLE_PLATINUM_REWARD,
            numOfPlatinumRewards: NUM_OF_PLATINUM_REWARDS,
            singleDiamondReward: SINGLE_DIAMOND_REWARD,
            numOfDiamondRewards: NUM_OF_DIAMOND_REWARDS
        });

        cubes = new OneMillionCubes(
            gameConfig,
            rewardParams,
            adminSigner
        );

        // Fund users for testing
        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);
    }
}
