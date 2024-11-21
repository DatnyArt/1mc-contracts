// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesPlatinum is Script {

    bytes32[] public platinumHashes = [
        bytes32(0xb07de40f67c8dd7cf2b7f2e514e6d0dbd91c32b8a7c63a28ad0aa6374b27b85e),
        bytes32(0xd66450de03889d6747b9e8eb5e154991c146c8aa3e54f0447cb880d740b4f3dd),
        bytes32(0xc67d0894f61f1dcebcb1088474a7d971e226bb077ac408eb071385f5b293f84f),
        bytes32(0x84ce98b41554862ec5982fe2b222c51a1c7c78a7b8c41ad573f79b8b29a401db),
        bytes32(0x63294b729b6adfb68773beccc90d05d8698cd456b1714aa0644fc9beec42ec1a),
        bytes32(0xbf339beb3f6195daf6ab0de34c8c47b9319561c44b8c1cdd464f1b0bd5572092),
        bytes32(0x5e8bcfd6c5a4a586816143053878e85a6432f9800f8d15670181f51d2ace703f),
        bytes32(0x4f50f10078535a7390f91d5a70b55918029cfa8470026ccad6afdaa29a2afbfc),
        bytes32(0x568ce36b872d8977877bb9330b238dba9287838d0b248dbda46aaae0f23833e4),
        bytes32(0x6be204d9644f1b017dd908fdabd98e51436c0620dda16ebc81c6240c925f4348),
        bytes32(0x9ec5e4cb965d9b826e9105441fa2fb7f8621946e71c0726e90025495b6debace),
        bytes32(0xc7bee3811fca3e797d9df88af1593dcfd03357bb80d4e27e38159c5407fd9ce2),
        bytes32(0xa4e4cf6b14007e53c81f3626eb35161d8bbde9097e454e1059960017910f9baf),
        bytes32(0xc6db54aef76478282cd0cdc34bb42e86d472a9000b7d9ba8ff7e4ac7420fb3f8),
        bytes32(0x3fd8e7fc9b6ef90a4f5370ecf9351a5a353f13cd784e98cfcd6da6b3e0094d16),
        bytes32(0x48ec93cda57cc41d19f91e8223d06205001467c58dddb2db20914c798c510faa),
        bytes32(0x986f3aa4e7e845bc0c4ae08ed21245e4e225499cfb70923c22d1b5d46bc63a61),
        bytes32(0xd24eeb698533643f5718e155ce8934201a451d49aca7c2ffcbe7a08f40db65d1),
        bytes32(0x65288434991b3c30d563c9dd3a0f79ed1f90e2e3c0f7f20e9cd3903177c5a92c),
        bytes32(0x085120ba3d90e55a6c41bcd7e3f99fae3c2cfb5f7b9072958b03bbb05632e832),
        bytes32(0x90777ee47b90cf950ca0f1fb9d92a9a0df6f4f1effd59257a225ea8b7366656c),
        bytes32(0xdfca14ece5e42aefbfb22b21c0b14004a184449fbc8cd69c42205e83cda39bfe),
        bytes32(0xe471547baa03dbdebebf47b339be9947a4f31f2b46801d6394431711d75eb493),
        bytes32(0x414d7323322300a7d07398c455b241623ff7e43f0749eed5f7b1d4f920698f13),
        bytes32(0x2878e9047281cbbcc98c1c9d552499ede41446a520ca37522873cfc9cad09640),
        bytes32(0x6723ae48d5eb499d48dd2bdf0ec200d97f1b67470b8ffe94a1ec284c1bccb9ff),
        bytes32(0x028627b7f4219d2a93af8c6d0f8d4a3adad2f118e42fc3fa995336483a12a509),
        bytes32(0xa6dda10a802a18bc67816b32cc453af60f2e175fa3494919786cfbf813890882),
        bytes32(0x333a59c7ee3fde61dca95ea705ecfb8afe395f5fd669ad17bf9fdc5a04a8b3e2),
        bytes32(0x3b4cb4781dff2e69aa4fa391c24279a517b9451845ff674ee30f973fbe107618),
        bytes32(0xebd1875f09c121226d1274fa35464f27e275c3e9d7cd09151e9e1f0128e64e84),
        bytes32(0x66c4157101a72b15b3e1634dff5bbf83569fa74f876fc3a1d3b18464ba55c254),
        bytes32(0xece1c701bdae0531002b34d833d8128dd2ffaff2526d3a1d25e5272f7e03734c),
        bytes32(0x3a84ea834b6a9138104f2528fa0c809fb78b6c617a07e9f26cc147578cb91853),
        bytes32(0x5c1d5bddbcba88d5ddf3f32954fab91e77da8aa48e79ee1002c7e44a45bc983f),
        bytes32(0x64dc3db141a1332af577470e1586f916e9a88f76f6ee93c3ee9cf7db8ae7548a),
        bytes32(0x70067464eb1d0d0bf3302041f683826133ee0c91f8639211c331572ccb6c3a0e),
        bytes32(0x7d4ec21ae426691792d4432936baacc1a3d769a12f5823b86a9bf96db5de4724),
        bytes32(0x7eb3cf9ce57b60cb5c9c814a6ebf6f4e6e8658b931edc5e944364b74e20bc7f6),
        bytes32(0x39b98e5494f1739993c5e0071411dc31c7ff25c51a960e2575c470fb24071200),
        bytes32(0xdce74dfb1ee42bb6156895bfb3bfba20e75bc291bf1764354bb3718db3d88db8),
        bytes32(0x0f4fa4a109b040a3f86987dea82c57f3656073ed260934bdf5acb8479c5aee8e),
        bytes32(0x7d1551c2ad3b2d3edd757a539ab74bd213ff3090c92ec56efb58044619d750a5),
        bytes32(0xf6d58035677878b9139e4e08c1120acc9ed98777f0292b7634e032708d450e40),
        bytes32(0x1dacbc7e69d8b6f26393470a2dffdbe5c9de6ea9ec0c836818bac5d60c1458af),
        bytes32(0x51b9096214b495e333eb1852d24df0cf76aa57740cdecf5e5473d3726a6b86a0),
        bytes32(0xb359d782a1dc3d1924fb49c523169cb257e9581ce5e3b07883f67574b1e6a47a),
        bytes32(0x0a77ad393ca6d0feff536df29e0cd33305a111490f382be533949b01f89e07bb),
        bytes32(0x2f87abf06ffed80fdf4626a21bc0878c8b8764146cb86ddf9930562976929b71),
        bytes32(0xe3cccea6d69066c8603ab48b83064527833368ee625777fe8d6bf3b09d3919fb)
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

        registerInBatches(platinumHashes, OneMillionCubes.CubeType.PLATINUM);

        vm.stopBroadcast();
    }
}