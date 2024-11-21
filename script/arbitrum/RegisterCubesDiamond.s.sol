// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesDiamond is Script {

    bytes32[] public diamondHashes = [
        bytes32(0xd4c61e263ffe9edb04dc3009cd10c9369a6dc144b48400ebdca02b54e9b6ff9f),
        bytes32(0x86556a2ccdac7cc085ed5d027a1003ed23e958c64e5d08988f58ed9f5c10c651),
        bytes32(0xcbd295c3d2859aeb0b99014efaa77ab83f3784e63dd81ead6bbb058dd5673d18),
        bytes32(0x5bc0df1b00ba7dffe3675d8790dc1927830e559530c433b46f0505ed4c74b1de),
        bytes32(0xdf1a72bc65350f4a3675796c6020f99af206eb728bd8893750488de7e5f28da7),
        bytes32(0xd5cef9b28aabd1ba4f74dd9ced9955f242a0ccf7ef0075bfc1f7d74624c6f29e),
        bytes32(0xaaa6b2d4ca17ffaf6730fcea0ef5c1e59ee3ec13230f20d96f7b40e2b5f86e63),
        bytes32(0x61eb2669be17452774bc91b5d8d7c1a59b385ee5c792199f0ada3cf2c315d491),
        bytes32(0x8258b831a0543098af2968e4492389e494ed7ebcbc635698f00abc516f05223e),
        bytes32(0x30b89cc9d1792f33a582261297eb1504b171150b876c452f1c919709969ba14c),
        bytes32(0x6004b26ab66b7526e1e8e480a5456a74194e8a73d8b585d76d9734a4321c3715),
        bytes32(0x33f6ecc0ef60e7e0c626cb9d0d0f40fd579e3f0e3b7bc6f683716e88974850d1),
        bytes32(0x466bc1f44375eb9771a47acced58ab4cc63caf6b1b74747ab7755136ede7cdc9),
        bytes32(0xffd182cdf42cfbe446e5f56539f8234eba33485da2d4af591d8bf9acb59066d3),
        bytes32(0x03cfc1c1496b588b117595809191b0c6b69eb5cc140cdd7adc547c0967bbff21),
        bytes32(0x9a2d2fade028a161b125be4188aba19e90d254a512e83b36f9995213929a7e07),
        bytes32(0x1e6c94f4eaa2ebbd57f87286e9d8ea7bd1cf1c58bf6dd52aa182f5b93fcd7da6),
        bytes32(0xa91ed87d269e857af0e96ad6b22e729453fa34c057f4f38a99639d5f22cc49c1),
        bytes32(0xd8fa74fa7c805feccc1f0795e8acddd1500f9792f6d352f17e46c5ba5580fba3),
        bytes32(0x40078276202c4d7a1542ef8c32eab9b5c35690b4262670b229748afb4bf83c82),
        bytes32(0x746ec2493633efbbc8898694aea51d524c2037ade4351e8860154b7f52f60898),
        bytes32(0xb4731be38aa2f628ca82db47ca35184e803a8421c310ae3601dd1dcaf874caac),
        bytes32(0x2770e650b996439855cb0a17186694232f9b2b2a07bc7269c146b12e27dc45b8),
        bytes32(0x4a016ca98a90bb5ed419fbd16eee791ce8debb24147300a3e03b5ebc4b9b68d4),
        bytes32(0xe2bdf53d8963553c7f5e0d81f4634bc2f7d52540ce840c71d9a3eda6097a03ad),
        bytes32(0x58ef470de4e67585a70250b1b48189bfa9c6302480f894deff0a27fcf42fbd40),
        bytes32(0x5cf32708bcfd77a949f703448e06519a4213f1b6e6d708bc1d27c4d5e79150b8),
        bytes32(0xaeccac4d09fb3bbc71f2408e42f6b87220270cbb4ad19a63701a44f702582f18),
        bytes32(0xf777bb35b97cd803add99aeef6ca267a0053e8c93c43fc419334910ada546382),
        bytes32(0x7d2ce0a25aee40214b19b9f7a0496d9e52c341383546c1e4ee4266c3fbe7feae),
        bytes32(0x45db4ccf371c890e5a2edd6b441618fd5e5f82c332ec5ce6c7899c5e38f84a9c),
        bytes32(0x5b730454504c0dde9ca5c8965de511b3e0f35fb698146700d48e1acc8453fd66),
        bytes32(0xcf109fb7def48f7fedcc3166c6f4cfdcc1609aa52f5b27fa1167f5f461e3bfa1),
        bytes32(0xe3e97d2d150173d2951c1832e59338f85199a3997aa29c1f2f917dcb31183531),
        bytes32(0x60a4c966e6ec04200c6eb15bda3515194558e278c9db7604d0878ed58f3de05a),
        bytes32(0xed4e20df10dfb9d080f11c6ba862d5e59e492a3b015c2f6aaa8a4686d1b01767),
        bytes32(0x6bc7f615b1ddbe6821ca19f2c3e16dd0bc0d944769219115b73d55079a71792e),
        bytes32(0x87d08607be96baa5d0d7a5b07d9134317c7f8b3911464680e56e36e618390150),
        bytes32(0xbf211714fd078420c5e8cb283b833798a9de000cd6b69b54b381dd50bd9554c8),
        bytes32(0x7971597072af91e8eedb578b63c8f79ad607d12ddf2d6198b1e3afab88951f9a),
        bytes32(0x5828aaba0df1d3610dee9899486d00ad383a16b043f5433454a2a19467c86271),
        bytes32(0x7c6f7fe7fc4e9fbada7a08f20a2ce0785634400f10eab1442235caa1360a08fe),
        bytes32(0x2e81a6891bfa60784f4ed58d05f0f66000f5b61bb7d4d771d6e863507fe2a9d6),
        bytes32(0xa7ccfd030f5abec580ddba8bdae5f4d8546413a187280ed6b37448ee8d678a88),
        bytes32(0xfaa8ff8a1cfdb80ea621412fb71d1b3444cba1d032cb3e2d56503be968fed385),
        bytes32(0xf97e49146831616505be59ccf558c08d386ea1dcc4c7afcc8de0c7d120a555b4),
        bytes32(0xfb886408a91b230e93bd0addd68f0588c1b81433efe33566778f6e4d08878a33),
        bytes32(0x055f71c857a57a96df4cd4c90e078f4050dd79703da577840e84c44ffb211a78),
        bytes32(0xf925382fa722028842c7062fa74f9a995ceaf12792307c5dcb4de2172842aaed),
        bytes32(0x5d554aa237e5c999d95203b943615f1079afccdd8b034f9daef68adc68507a33),
        bytes32(0xbbe404922271bf7e175237a739247edbca5790d574e678919c0c85ced5e844fa),
        bytes32(0xaec68d2d65b7a8a3ce8bdcbd50c81f466a70999628db80cefd72ec7a9ef7f80c),
        bytes32(0xb714d7dae9f2218d096c8eaf6a183ff8e874810853b2843681e16f76c34c8eb3),
        bytes32(0x0acd0a7e4c40dfed14669a755db944259460c60221c35aeaad991d52bf042f24),
        bytes32(0x14c2e1ab521d1abcb54f7925a98a0d7ecbd1d2a183e04cb0171eb6db7b6c0de7),
        bytes32(0xef3a75bb9d6a136f6eeac619cf7132fa1fbc69eacee3e343741ac3c92ee98521),
        bytes32(0xf7c9b492db61ee5aef9f4ce2d1ea1e313eea1bdd896598d827ee34bc7ee35648),
        bytes32(0xb45a20448e9751428b64b7613b4615c4d23b5031bd9bed8bd26482b0ad84deb3),
        bytes32(0x77f7aeed0f1050eabd6a930788fd026d2f482798e089bb7fda24084722d7d35e),
        bytes32(0xfa94fb881abb1a7c9819a48825dd5d31db7c3e3967a6ea2c260dca93710bc0fe),
        bytes32(0x88358eb3762dae30e26c454fb2fd26523a5c518a78ff2271a35a55e6ffefccbf),
        bytes32(0xb77a11a1d2fade0403c202fcde258e165f0a6d4dde1778fb95acfa37b0a4bdb3),
        bytes32(0xbcd64bbe0a7237f7f0704a817e90cfce655bea6a47ef3980265b011636674146),
        bytes32(0x5dd7fb71ce69985598b124a2d5bbbf1931cb8aa3ba4c64d98e9b10842cc4af12),
        bytes32(0x060788e7865a54d67e57f9b1ae4b865dea55e5b83a5ce5b601dfda012a491feb),
        bytes32(0xdb1ccc0ca915203f1d302ece1e72f32dc1c3a2aa609dffe829249af4ec2af31b),
        bytes32(0x9247f981352921b8b09d8d7df1eab9d7d1c5e1d570840374e65cac923d2be88b),
        bytes32(0x7426d5423e9fee1e4f444356bf93174870bf324a3ae7c25840d55b8c1248784e),
        bytes32(0x1892d4151383d93394d7d3db0e83642fd40d6b42715ca7b0c313c4726b29fc8b),
        bytes32(0x8479f8c7372612b7d99d0a32caa6610984863c4b2d5aaf4f7e9cf0f7e511fddb),
        bytes32(0xe567ca526115e21d7431a43b99bafa929975ddeaad15d0901ba0dfd398a59b90),
        bytes32(0x50701cf5fe4372a5293d4b31ecb9442c0348eaf1f5f19ccab4edc2ba4d9b3c33),
        bytes32(0x180fba9ca2accdea599631a1a7826ceda63a68bd63b30d1ef661fe26ecb327bc),
        bytes32(0x5d4d58652ab86394dd09e948df2eb31b248325707fcba90db05463e8a68429c2),
        bytes32(0x5fafaff0f2c629733fa0bdba7517f413a2a6f3a83a867cdf90b4c619fed30519),
        bytes32(0x20ab9254098619cbdbdce56571f1a6bf7b70680f08d9b552aacef3538e5eda28),
        bytes32(0xb8a95e7440b59a81f4c583673bd5c2895141c805e1bacf1912cbacd975fd6a38),
        bytes32(0x9bb88fe352adbd38d3da82681814fcd8de745c4e6a2b930ce58eda5b2ca53b7a),
        bytes32(0x1b048e29a489cac812f762ad6344ee728702b9d130a2e0e394c7a6c5aaa241b3),
        bytes32(0xa7ca1185ad2222143a3488f88b1f9dd217638b00ce4818390760aa8df588545f),
        bytes32(0xe2941fc0a8d7cf28446c965292d801740cb56abb3065c93df0a425690bc8eb31),
        bytes32(0xaa8ea47707ba575333c9d99fd186784c78251b30196ec1b8c34a08d51abbdbf2),
        bytes32(0xa207ade47bdc325f7aa19b04749ef631affc98cb15b207267a4f1056ec11809b),
        bytes32(0x2b63819ab634f4dc1a9ac8d28d57eb377803499e7079036df441f3a91ab82b0f),
        bytes32(0xa7f9ddd7c0f997a45e3f34555cd1f4e4046746f76e0783e9ec6772d0f6d9ca63),
        bytes32(0x665d90d75b5ef7315aa35c518fe6377d364ec19b2d80226a8b18f5b9cfbef787),
        bytes32(0x27dbeec9115d25d689fcc51e35f4b762fdf97267be94afaeb2985427f843ebf5),
        bytes32(0x8cfd3a18ff17de2b2937a670348cc5abf115a0ec813cd46f49b899b14c263997),
        bytes32(0x1584976ddb7597254a4889b17a2b9c3ecf2f986f346ecb6eb31b67b72a8f1157),
        bytes32(0xec51afed049211ee638ad667510931c6af12cdb874e60e1ac1d3bdc263963467),
        bytes32(0xe6f192e1693a4882736686f7cefed250c52672a01950de3fb602be32b7d0d6c1),
        bytes32(0xab57080092c8a09dae4a8cc40dbd5706fed9e8a138d8c002131515c4b3e6f134),
        bytes32(0x78d61234528726bb364353643212822bafb7314e777bb8f8c9b7eaf097314f9e),
        bytes32(0x067d621194d35a0c225a7e6d14cf6ac14a2f076e87a7cc74f66c794a838638cf),
        bytes32(0x3d0e30ed2d14a1987c08f030f19dbdf5f24e9b3989f4f016b7e0efdd4f26049f),
        bytes32(0xee94a05df3a0c5881c685746af43fa95abdf42235523b243dc40368aa450d607),
        bytes32(0x63d23af2eefb86a020d5ac20feb04002c388b26951fdd265f114427046e0f034),
        bytes32(0x4fea6329fde22dcfe09fc3a524323ea952225f37db5f462b3d8a35175439988e),
        bytes32(0x25c5b9ea681f2cb57c02eea82df89afdc11c2da41e9f36c1ace30c28e4333e43),
        bytes32(0x4fd9d7ebc99279de77f244c3b7f02af499ff38f0ef37892eb3c0840361e7beb7)
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

        registerInBatches(diamondHashes, OneMillionCubes.CubeType.DIAMOND);

        vm.stopBroadcast();
    }
}