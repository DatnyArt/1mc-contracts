// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../src/OneMillionCubes.sol";

contract DeployOneMillionCubes is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address adminSigner = vm.envAddress("ADMIN_SIGNER");

        vm.startBroadcast(deployerPrivateKey);

        // Create game configuration parameters
        OneMillionCubes.GameConfig memory gameConfig = OneMillionCubes.GameConfig({
            fee: 0.00016 ether,
            minDiscElemNumb: 25,
            blockNumber: block.number + 10000, // Set this to a future block number
            totalElemNumb: 10000,
            maxSelectionsPerTx: 5
        });

        // Create reward parameters
        // 1 ether ~ 3175 USD
        OneMillionCubes.RewardParameters memory rewardParams = OneMillionCubes.RewardParameters({
            singleGoldReward: 0.0001 ether,
            numOfGoldRewards: 3,
            singleSilverReward: 0.0002 ether,
            numOfSilverRewards: 5,
            singleBronzeReward: 0.0003 ether,
            numOfBronzeRewards: 10,
            singlePlatinumReward: 0.0004 ether,
            numOfPlatinumRewards: 50,
            singleDiamondReward: 0.0005 ether,
            numOfDiamondRewards: 100
        });

        OneMillionCubes cubes = new OneMillionCubes(
            gameConfig,
            rewardParams,
            adminSigner
        );

        console.log("OneMillionCubes deployed at:", address(cubes));

        vm.stopBroadcast();
    }
}