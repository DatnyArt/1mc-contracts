// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesPlatinum is Script {

    bytes32[] public platinumHashes = [
        bytes32(0xb558b5a68dca6e805e17ac4a0da4651889ef46f8b59b46c52ecd9eac99687569),
        bytes32(0xc737e7cd763de69a975c8ff64939c7f5ada1e8d7fd13dc36c30c4c827da29010),
        bytes32(0xd1c3871bb63aa8bdd2a53d5b3ef5deb6678b1965b9064334e87359f457190f48),
        bytes32(0x6d644453bb4deb3aea8f442205240af8e775ec4ccf0370befa12ebc014bef47a),
        bytes32(0x3db5f435e69dc5f28f8490ec825ffb98c9bcf3f439c358eb4cc097a666ad35f5),
        bytes32(0x22fb320be0d25e61d216d4730e5d3c9e4cf009a81a6dd459b6f04a8db7336f88),
        bytes32(0x834277623fa77879824b599eee8c0ec6a77204219beb4af1e85a75d46c3254ab),
        bytes32(0xdfb128a8eef690945023879f86317b7d4d95ff8b8f29283486850270a468bdba),
        bytes32(0xf58b78ce9c9be5dc6602525df1bfc88b6cff755db2b3c85c968b08ce56c9d78d),
        bytes32(0x046d82f7aca57ef071be1292d882c2aa64f56ad8abd81e49a51661ed27abd48e),
        bytes32(0x03d3e79f7953904eea1421d09f179b0a4853bdfc827f06f76f527c8366980d2e),
        bytes32(0x76a8e04569061b98cee3fe9c3b4ce53a9a13e8ecd1350af07202935c4a00158d),
        bytes32(0x5946e9e355a843f3929db486050fbce09ef9fedaa5ca5b2512f83714f74d27bc),
        bytes32(0x3b744cf33e412178f006be623572993da3a14d247a74c1a263e7edad62f89c1d),
        bytes32(0xd86877404b3ae1e592fb0fe9be65ed6c6aafadc87e0b1ec9a0c66ed250087c49),
        bytes32(0x15cb4b30664072dddc0f87fcff3512672cef0db094abf8b9232c3c4da4fd76ed),
        bytes32(0x7d51100d9922f1be43413476431d88e8daaed161225e78dec8378b48ce997923),
        bytes32(0xf86fba2fa565ccdc1d22947670157a7fb1b2c8b9876c9e15e96b126fe8632a98),
        bytes32(0x3f604f81df29d1e956ca50bf9840ace125bb103519ed7792883872c9dbaacce1),
        bytes32(0x1a14af806405bb1635c07df2ff1f6d8ac650455f7322bbb62f8d0cfe7b986ea5),
        bytes32(0x7f3ff6d339d880035b062cbf53a2635dab9833f4f9f8fd4dee8529cc87b10786),
        bytes32(0x8773f1499b372a78bea7e8d4d4c960a84c74405df58e709f17724f0a1a62692a),
        bytes32(0xa19dbdc8e1c7b0feb1db59bd637cdbb583b744cee7be4b97b6c095e5a80899d1),
        bytes32(0x0d896448becbac10f14cad39f425d8a3447c06312864d420671d1caf70db56d2),
        bytes32(0x34a8f84addb898f5f158ab361bc02560291a53f0178c78e14274d5397e262b61),
        bytes32(0xe6c07a8c3e556d695613b3be1f13a2b8e64175bc221c7a0b28ffb0b0c49e25bd),
        bytes32(0x3b097e9f10c5573fe4d14c7c4924833e81f8172eb785938640048f480995a28d),
        bytes32(0xff252809a16b9deb1fd4123956b724a8da2fb9de8b07603cb537608a83e5542d),
        bytes32(0xafef435428a64162f4ff960cafe363a64688348be484aec0d9b0fec2a6ed2c6f),
        bytes32(0x756315536f7f1504740e2eea522e771912670f990a95cb99894469719a45cb4e),
        bytes32(0xa8bfbb244f662ad30cea5dfaeb820987ca84447d35d4fda05e6f4e7aeaca8838),
        bytes32(0x61a6b658ce2bfea38dcc7cf1df1869e71e775975af26bd26e1aef245e086c2e0),
        bytes32(0xf950a4cc658b1440cb939c2811001d599d71225987ef26af87e43e82e0cbfebf),
        bytes32(0xe180328bef154efeb01b1e82dddf2734fbbed9ecd7a5eb686fc18716a2fdd513),
        bytes32(0xa1d4443836411dee29aadeccb350ad7da7cbd84929602ad322b2c22fcc5068f8),
        bytes32(0xa910b196a2bbc50ba4a8866b497d453e54b738fb9d9f448d23c6da3765e38bcb),
        bytes32(0x78ea5b8506468644ea2f4effa5acdf190e12a6fd97d9670d30d25720167f619f),
        bytes32(0x03e221c44d3ced1fa5652d9ee13afd778a894868acbb463073d9445ce6d8a9eb),
        bytes32(0x1b33eb997233e497a4b94340d3641379d4f4e0ddc7ac2415069055b842cd59a7),
        bytes32(0xc5beac4f4fd38fb1f9e47d79d3072c942e627277f9a99fa97acdbc6737cbc73b),
        bytes32(0x0736bf02180aa32bfb44950645cc6d0f429e64842e4efcc0ba9492cbe31651f1),
        bytes32(0x21a2b8a7f6294d95b9a546f4ac0eb5ed115bec01d20e53862f6041937593a8b0),
        bytes32(0x1e1fc56353bf0360db475501b22ca9f1a82745b328003f355937bae9812f89c4),
        bytes32(0x4b0af15ccfef2f5f24c89117e3f9c8f606b522110c45610876156387e03e602f),
        bytes32(0x5d8bc758252080a1c4e3c47385957592667a9d198ea6947b1634045ef42dec01),
        bytes32(0xa1d25de6c950e7feec7d8299279b3ef22bc7214ff44c6afd54d0bf9e4d088b8e),
        bytes32(0x08abb93aaee3fe6bab6853f4e92316e00c46c9826aca163f5d3ddc0e309fffd4),
        bytes32(0xaa694cbed3c7bcb0f452af9243a2a4a7e273db52e567f7094fd6f36439059b81),
        bytes32(0x2b80efd3c901d1b3bb4bdd6c09a7de12e59e0aeb6230ef7e3db7167fe669a0ab),
        bytes32(0xbbac710fe7e82e375cb967b2351d60735b59e9a7f6063ff390d0de2ac5927480)
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