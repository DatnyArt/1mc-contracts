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
            fee: 0.0015 ether,
            minDiscElemNumb: 800000,
            blockTimestamp: 1740484800,
            totalElemNumb: 1000000,
            maxSelectionsPerTx: 5
        });

        // Create reward parameters
        // 1 ether ~ 3320 USD
        OneMillionCubes.RewardParameters memory rewardParams = OneMillionCubes.RewardParameters({
            singleGoldReward: 300 ether,
            numOfGoldRewards: 3,
            singleSilverReward: 0.15 ether,
            numOfSilverRewards: 500,
            singleBronzeReward: 0.03 ether,
            numOfBronzeRewards: 1000,
            singlePlatinumReward: 0.015 ether,
            numOfPlatinumRewards: 5000,
            singleDiamondReward: 0.003 ether,
            numOfDiamondRewards: 10000
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