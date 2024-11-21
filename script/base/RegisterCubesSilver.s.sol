// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesSilver is Script {

    bytes32[] public silverHashes = [
        bytes32(0x54ded65d140a27098fbb6e2e7f8721ed8b09c08a1a416ba7d378a5b86366630f),
        bytes32(0xf60505698f53616c59e95aab2614f445c1df4c93da34e221c3ac6d661078b975),
        bytes32(0xfbdc8b52d8597d7f5fdb6a447601ebc63f0fb8c6a2da535c201e528793668144),
        bytes32(0xb4841c4fca36dc9257c30ba9fb09a814e728e35c40142ecc7bac6cad0e93c88c),
        bytes32(0x88d98793f897a1a6d6af83c324e6df7c74060b859772ffb08a75d8c62dddc050)
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

        registerInBatches(silverHashes, OneMillionCubes.CubeType.SILVER);

        vm.stopBroadcast();
    }
}