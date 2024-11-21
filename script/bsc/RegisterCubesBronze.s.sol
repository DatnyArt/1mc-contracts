// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesBronze is Script {

    bytes32[] public bronzeHashes = [
        bytes32(0x66d681b462907ebe99e3077c0e224f5ea57c81bc4e31fbbfbf6897cf742905d6),
        bytes32(0xabe44283ed7cec750ba3fb9ca2062803de79817c8ce8f9f5332922766640416c),
        bytes32(0x41620eddfccbc04d5adacb644f4cfa690bc65b2e637c56bd9142f255d0cdf929),
        bytes32(0x3242ccb678832f76e9e4c879be6be0a06d6797660451cd83a6e0f6770b0879c5),
        bytes32(0x77e011552a26000cb22b0456afc9b42d7acafe63b19a0455c54adea7f7cc9837),
        bytes32(0x8b783cbb483239e2d191154efd743f06f98e3153267b360a4401cdc9afa02f6c),
        bytes32(0x8ec3c815cf54f71f608cd78c78fe8cb270fb553d0b1d5b8371750213c67834e7),
        bytes32(0x739a2fc44e103764669c5b3a77be7d8468dd19ff2ef24552a7d7e98f6865f347),
        bytes32(0x0b7a12cde4a9026f7c3a793950edbd307505b43cc8be3f7ff4d27a40ee936d3d),
        bytes32(0xc4b6b889acf9302e93b77dd01f865cceb9745282c13559a9badd8003a93d5d78)
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