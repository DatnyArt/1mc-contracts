// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesBronze is Script {

    bytes32[] public bronzeHashes = [
        bytes32(0xa4e80b2dd3fa2d74ef723a8364551fdc0134b907b0de06c59b272b69ffcb2e2d),
        bytes32(0xca3f12320946d2d7774b523c88f1412d427c3a7b7ea25eedb988bdba6552d7f8),
        bytes32(0x9ab4c7c794b4e6a3742700b9f40e1889b907a45e825754239c822e592151e6d8),
        bytes32(0x4cdef5ce215d8b5b50f0dbc66e5cf0977770c4721fec9ac43a1c2029f9df4309),
        bytes32(0xe81483a08f4d0f1a11de1d7e9c5249cb74d597909d2a41fecbfdb5215f900373),
        bytes32(0x86efc0719b1b9ca252b819e08db1121761db24e74a755aa1d7dcd929d0891f26),
        bytes32(0x66a70c7a162e6b1b6800d49f292a94ce171e71b3a1a13c85b227df0e278feedb),
        bytes32(0xe18026f2818da99c8d6cfb9fef24ab2ae6fea3b35466059abf356b9da6cd4b6e),
        bytes32(0x9f00d2abcfd966a3d98310e0913174acb9283a05adf005bff01632766bbe36a5),
        bytes32(0xe886ab3ad11a8f8d61c5e57616d7cee3850796cdd3e6cb6164aa0c19cbb549b4)
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