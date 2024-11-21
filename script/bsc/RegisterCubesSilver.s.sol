// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesSilver is Script {

    bytes32[] public silverHashes = [
        bytes32(0xe83be956b6924e3d93db11607d449f7bd87bbd2b116a10553969bbc066253fc3),
        bytes32(0xcdbd03a1c33cb6a4d686de83dc4c8fb728734dc2d0bccc554994e20fe5998ae9),
        bytes32(0xceefc10f5f3e511c740c78d81a22cffcd0f9a15687ce898a3fc413ca2a2342c0),
        bytes32(0xc0a688c940fae0864aef991b774686c9c3e70689ffa00f99e1deceff4310d75a),
        bytes32(0xb072a5a905b6d0527ae3ad9bb2b68e04b2da2dc22670e77b5de89d405790830e)
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