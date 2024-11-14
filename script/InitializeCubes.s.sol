// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../src/OneMillionCubes.sol";

contract InitializeCubes is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address contractAddress = vm.envAddress("CONTRACT_ADDRESS");

        vm.startBroadcast(deployerPrivateKey);

        OneMillionCubes cubes = OneMillionCubes(contractAddress);
        cubes.initialize();

        console.log("OneMillionCubes initialized at:", address(cubes));

        vm.stopBroadcast();
    }
} 