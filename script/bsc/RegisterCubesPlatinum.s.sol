// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesPlatinum is Script {

    bytes32[] public platinumHashes = [
        bytes32(0x8222551f22d039169dba6a8a958298a4a14529382122bd9fe02837af4bc6281a),
        bytes32(0x3449feb79d08922a9dbc5787dbd9fb69d58de47fa79d2e292722c5b950193ecf),
        bytes32(0x8e2e42c453610e14ec0d1b91bf02275e9c41e9f250fe51b183c7cff4c0916da5),
        bytes32(0x517208a5fb635e9f95fc221d01bb80a0cca25234018ba9d52fd97a083c52b5c6),
        bytes32(0x55524471ac17dfa2fea00aa2f5ea1f1ebac171d934b146cf9186ee60d60d6c66),
        bytes32(0x14cd995e3c39edcdcdfb8871b18ce36a25fa805b01bd4d6f36cddc840825dc07),
        bytes32(0x59ded6b1dbe9e328928fe3dda140880e81437b1cc0d3aad81fe1c403036f79bd),
        bytes32(0x03e4e0ad0f314eceb0a8a168430aeb4143baefc27cdbe82cdad1d1ceec73e693),
        bytes32(0x2650b8d9b7f42e871ff4190ff492ed5f2f71f876ea2a7978aa7537806b8f6eb3),
        bytes32(0x69dba6c39c43645f58330e3f125a5e28294853937db2e78563e58ed7c802a3be),
        bytes32(0xad34596ee97899046636eafbcfb64c24475d005c0ed52a203a5df40eea859a29),
        bytes32(0x0d2cde752d260b91d38f65c8f128fca849bbb58a6fafabd5556b2501031f4f6b),
        bytes32(0x355f8d107aa4a5634178e67097b2cab1d641ef4c1c5393947945493d5f00cb35),
        bytes32(0xfaeff58e94be653a0721de91603037f7f6e12b729d3129cb0b49e27728d59d35),
        bytes32(0xb8bfd8e5e87801f0527a294ec92e9431b57890030191f302c413d398f68df5d0),
        bytes32(0x203008a1653f522e3006308a65189d6b205559499dfd19fd773d97a2d895bf46),
        bytes32(0x4f343bcea9339cd5e2244477e73ab83f83a74581dbda38d0e3ccefe4929d3f17),
        bytes32(0x6b0730e96f6d88e4184eafa29e974e5c2b5851e3235d5a0fd153061c032b57db),
        bytes32(0xf5d5fdc441749799a716960d9b00b7f20c8d89a1cfb236a4634f720eea117e43),
        bytes32(0x8067af30120ced28c2078fbdccc9dd400562c43a72e71edf2b7b0dff4ce4d3d4),
        bytes32(0xd6ed0ea9f59e139546c89d9866be9fc8ed264aff7547b986d1486c4d5a7961c2),
        bytes32(0xe5da40ca771b3d241ddcc19a8e2bbbfc15dfe08598eefb89afcb1189dbb744b2),
        bytes32(0xecf9ebe0fe69904f4a536f25c58cd1a7424d38081b088cf29ce8fdaa7ff05c4b),
        bytes32(0x2eaf73c57f381eeba287009d055eb97f554539c1bc542dab8b729d229437ec3b),
        bytes32(0xbea163a90a1ecb6856b4d68e6e8f371e2625a61bf4c0a8ee425329389eeb5bf6),
        bytes32(0xd464e34d7ee392961b829df9278c5555833882067254d264d65e21a0dd09a057),
        bytes32(0x3f789ea5d35a9cad48fcd5bf615b13098e13ad41c26ff5c5d41807aa42481f5b),
        bytes32(0x1b9f19ebd8b10d41b7bccbcab144dca6bbe3678c5373d2a93483e32360bfb001),
        bytes32(0x246faf7c7d88b28368546e973dcc03e4ee8705b99b7168b4422cbf260d6373b3),
        bytes32(0x08875f5b85a8aaf92bc43d54bc754799ed0aac8d4d9f052ced72ed4d3c2502a0),
        bytes32(0xf892a12fcec0523926801387ca56d0c94bd2a4a79c2e15bd773a4391ad2f210e),
        bytes32(0x4361f98d5bce3deef1436190f930fa1cc591a9c7bd5c8c8413563f957ec265a1),
        bytes32(0x192d77e04ade14dae415c8d582190c76033f38ada5829c2d5251406212589879),
        bytes32(0x5df462f782dff7eede22433c345899205306a6a2706809a63631b9c2703b3aeb),
        bytes32(0xc5e647cca6721a2d09eb81d3c3c289af8862a423308140a8833ce0a1a657bcbc),
        bytes32(0x2127a25478f9d910a9b579756b4d40468f27a28658b923de2aae58d64d710de5),
        bytes32(0xf0d0be52cc5ccc05ca57a6bf839f6be272a37b121f609064fbc888d28575b705),
        bytes32(0xc582ae2bd9e73930a26a7886b3575eb1c4f613ea7fa75906b6b30262bf058026),
        bytes32(0xe76bcd1e95c1668cfe8a60b58fb096aa0782af60dae72639cbd24bca23333791),
        bytes32(0x79515ef423cf72815076bb58a60dd1db0865ba6579baf7596e952325903ca213),
        bytes32(0x383cd818d7c91d33578ca03aef79c1dba18fb1474e4f9106992647bfc54c3290),
        bytes32(0x5834e8aa95cef1aa480abf30e97c36078caeadbbfb2b0ac41c36bdbc2cb380aa),
        bytes32(0x25133da51b6fb4341086ee2431468a293ee2a59e42104ce39cb9f8ea4c718a54),
        bytes32(0x789b5a143f1d3ddeb34f2e65bb5077feea316aa76cf2024593c5050c1e5d9b3d),
        bytes32(0xd8ef64fdf07dcc1a6dbda3f22172de3e26a880d2d44839b4c47e47dec7499c81),
        bytes32(0x122e696b1d51f4cd8424cc49fa2bef221dd5ede58fc9caf5ea33dc1aa1705b86),
        bytes32(0x5e8fd978ef67fb0eb8972a460150465e70f3fb5f5934b4863d4fc47c104fe444),
        bytes32(0xa2708a1ad7ef013a4a9e53ec31bd23a1124da9eaa491baac27817e9cdb875761),
        bytes32(0x23ae268d6de6d33080273203ef01ee1f37c8fd689d9a4c2d03ffeb07f2c39f32),
        bytes32(0x9f27166b824a8493c65d6c63e5960201ed6932803a87577487c2fde13a35f32b)
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