// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../src/OneMillionCubes.sol";

contract EmergencyWithdraw is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address contractAddress = vm.envAddress("CONTRACT_ADDRESS");

        OneMillionCubes cubes = OneMillionCubes(contractAddress);
        
        // Check if caller is owner
        address owner = cubes.owner();
        address caller = vm.addr(deployerPrivateKey);
        require(owner == caller, "Caller is not the owner");

        // Get current block number and required block number
        uint256 currentBlock = block.number;
        (, , uint256 requiredBlock, , ) = cubes.gameConfig();
        console.log("Current block:", currentBlock);
        console.log("Required block:", requiredBlock);
        require(currentBlock >= requiredBlock, "Block number condition not met");

        // Get contract balance before withdrawal
        uint256 balanceBefore = address(cubes).balance;
        console.log("Contract balance before withdrawal:", balanceBefore);

        vm.startBroadcast(deployerPrivateKey);

        // Execute emergency withdrawal of full balance
        cubes.emergencyWithdraw(balanceBefore);

        // Get contract balance after withdrawal
        uint256 balanceAfter = address(cubes).balance;
        console.log("Contract balance after withdrawal:", balanceAfter);
        console.log("Withdrawn amount:", balanceBefore - balanceAfter);

        vm.stopBroadcast();
    }
} 