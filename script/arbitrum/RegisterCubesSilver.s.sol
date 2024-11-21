// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesSilver is Script {

    bytes32[] public silverHashes = [
        bytes32(0x8b3312b528de3f637be666467f3036077736f8e377bf12d4c24725a4b495321c),
        bytes32(0x72bbde10497fbdafc671ffdbbe6ec2ab2e297cd98ad0c9d390f5eb931691bd2f),
        bytes32(0xbf4cc33acdbf9c0750be070729b8acda8b41e22bfa37683e9f82106de1d96d68),
        bytes32(0x607fe16b6591f90f9f31e91e8d2a19203a047c08ca8953508d6a9cae61927d3a),
        bytes32(0x104eb4e5dff356710a2b44a94d94a3e1f294b8cd75c6357235aaa29c9de6bf57)
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