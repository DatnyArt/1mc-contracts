// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesBronze is Script {

    bytes32[] public bronzeHashes = [
        bytes32(0x6fe76b577a9f065efb26cef53e315bf67fe0d2c087f40e12eae9737487b63092),
        bytes32(0x4f4a9af76baf051fff66b2b1c9795e0ce79cddbf8d2a6ea7c5bb995bc27ea7ce),
        bytes32(0x6a491eb5094c831535f128c506523129c6beddeb8dae67ceba35686fb597604a),
        bytes32(0xf3b758e4eee3f446f9db68f91b81241a83cbad3495b5cc1edf5821752fb4f1c7),
        bytes32(0x1b0b187d669d7e91674b35568c93d36b8d98051eb2cde79a8b3c5938daad7fa5),
        bytes32(0x5d11e8ce5e781a0bd197391f73b484be629844bc91fff635a8d9cfcfe4dae74a),
        bytes32(0x07605e9ef7c4814e95153d6a833d4f2abab0bfa51bd34e9a5ae1a37f491f0a01),
        bytes32(0x67e08e23e960d0926a2726fa8f2e91304afa3ca54fc1ffca8bcdbd3158fcfae2),
        bytes32(0x3b44b45cdee1cd70593068237745313739c865a27beb9405d8e77eb3244bf992),
        bytes32(0xc42d722ee19bad16b440908a7f5bf6d4ae600e61d8a1639a18ac60c73d672788)
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