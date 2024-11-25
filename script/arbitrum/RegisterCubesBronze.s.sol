// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesBronze is Script {

// TODO: Add bronze hashes
    bytes32[] public bronzeHashes = [
        bytes32(0x0000000000000000000000000000000000000000000000000000000000000000)
    ];

    OneMillionCubes public oneMillionCubes;
    uint256 ownerPrivateKey;
    address contractAddress;
    uint256 constant BATCH_SIZE = 50;

    function setUp() public {
        ownerPrivateKey = vm.envUint("PRIVATE_KEY");
        contractAddress = vm.envAddress("CONTRACT_ADDRESS");

        oneMillionCubes = OneMillionCubes(contractAddress);
    }

    function registerInBatches(bytes32[] memory hashes, OneMillionCubes.CubeType cubeType) internal {
        uint256 numBatches = (hashes.length + BATCH_SIZE - 1) / BATCH_SIZE;
        
        for (uint256 batchIndex = 0; batchIndex < numBatches; batchIndex++) {
            uint256 startIndex = batchIndex * BATCH_SIZE;
            uint256 endIndex = startIndex + BATCH_SIZE;
            if (endIndex > hashes.length) {
                endIndex = hashes.length;
            }
            
            uint256 batchSize = endIndex - startIndex;
            OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](batchSize);
            
            for (uint256 i = 0; i < batchSize; i++) {
                registrations[i] = OneMillionCubes.CubeRegistration({
                    coordinateHash: hashes[startIndex + i],
                    cubeType: cubeType
                });
            }
            
            oneMillionCubes.registerCubes(registrations);
        }
    }

    function run() public {
        vm.startBroadcast(ownerPrivateKey);

        registerInBatches(bronzeHashes, OneMillionCubes.CubeType.BRONZE);

        vm.stopBroadcast();
    }
}