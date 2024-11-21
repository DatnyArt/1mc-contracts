// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesDiamond is Script {

    bytes32[] public diamondHashes = [
        bytes32(0x43676b5cbcff3a680028d94feb33f290c31a56e334bce2bab96c0549cb9ff802),
        bytes32(0x1eb9eefa7e3193eaacb1794a261a81f5c3b0e3718c3e6f7f81c865ae39118dd0),
        bytes32(0x36a8a1fcba2452abcd236f910b91d0d4c49d466d6be2505e401391b5cfc56ed8),
        bytes32(0x6fb83957432c182e36a131c483685ca0a52f1aa36607f916229e3cd0e471f2db),
        bytes32(0x3172518b6f7e9f642831b9ceafcf43e05b7ca8c3269b65cd4f4c08ecda15f100),
        bytes32(0x76c5b08dea61bb9b93916a52292c4402a9a81687f020d220ad3c894a1d2a9b27),
        bytes32(0x29200f4544a9d490ab5ff6e5a7091da10bedcc3bed64caa1348960de3a70dcb7),
        bytes32(0xbf253e642cb97aa257dfd869f0bbc1861b67aa661d694a054cfe16787d6e83fd),
        bytes32(0x3328b52e6ecc5b1e262646bce0fc68729cb6799bfd0cbc1ded367a2555086564),
        bytes32(0xb8d92b631c7c56a8f956df50d04b84e437ec6c89b79eea55f118e8d69ce4ab25),
        bytes32(0x0ad439e22fa62cf52e4cc661638a4337997ad70c08ebc2f9a3e7f6b5cc6a2c39),
        bytes32(0x222133c526d3347afc03f245c19494832c8de5b6d5c7ba2427eb2043f5b1d18c),
        bytes32(0x1b635cf5969d8eca7ae5e8b52e52d18f601acb29b2cd2894c8ba3868c83d6d72),
        bytes32(0xbf5f854712de99f78852ea214f2af855b57a27922ec6d882146aa4a997da41b3),
        bytes32(0xd8c523109aa7be16cf34f819ad080c540f98d1d3038a2ea6df8cc7e77d9560be),
        bytes32(0x2d8c7331e35763c33dc1052d59b67e268795a437603e023efd16685c983c700a),
        bytes32(0xcb2fede4cebe9540062a614cd72684f0e86295e4463058513fe52adbe3acaedf),
        bytes32(0x18ff443d52a0bbe000ee48bf83bd8660b42e567ad608dafe1eb9658bcb61856e),
        bytes32(0x311c37bc71dd5b2ef95109d227c40869068cdfd051b63826157f8c0d032770cc),
        bytes32(0x44f461d3a93091d9f1d8efbe62e60b06d9b8243e95392e71eeb1eae47f247c24),
        bytes32(0xa75dcba72ce9590860984653439376184149054ddf2b9b40ad67331faae4dfa3),
        bytes32(0xaa2c15720042f02f793ab788e518ec097bb416287d800bf821d23203059eda5a),
        bytes32(0x40766dbcf5bc9ce8b2e809b70ef2fd2319bae6badbed3c13b66325111166c1d4),
        bytes32(0xbc0433eb819d6c61aea83d19899dfdf75333d4367abebd63a63bb5628e77a537),
        bytes32(0x1bc5128d4597acd8af49904d824e0f5708146e456173460ad38c6fff0cd49667),
        bytes32(0xe5d145711562e19f749b5a6bbaee9d4308a6fdb100b52597fded27f8f7b92cdd),
        bytes32(0x3d32851a7003208a8bb8462203f9204ae91eae1848af832e217b1945910137fe),
        bytes32(0xb1fb5efeb460400e363fce4a6fc8a8861bdd1833e98018773d2f7e2ca93fb148),
        bytes32(0x215953147a3b33231866c55ef6f354ee909079f2374fc24eb8f1282c65de39c0),
        bytes32(0xd3dd1a26e9ccf2cfb6b68b8f6973791c2a1f6f6fcd586e598161da992cf6feb6),
        bytes32(0x8cf9cf81205fd6f41f2192b285d62160d69392096bb780cd352f205200561ec7),
        bytes32(0x4e56ce246af21744751cfec262d7f4deb6290f5285449d0f4642de0e79fc596b),
        bytes32(0x9fa6cb9a9e52fb92565fb4464791107569497356dcb6b26574fad4f598dc606d),
        bytes32(0x0c34d904dfacc5f9aa38f565b21f58aa64d2167758d9269568c292537ff5c532),
        bytes32(0x421ee0c173931cdb6140dab311a587152a53e63fc7c54f670e06479c83366884),
        bytes32(0x5caec6650b8b3f75592ab7170f927ce7d379dc5242f1373d5e34331fe50cafaf),
        bytes32(0x11cad231b715f64050a3e0afd2bce359b2550e0ff5e480a60d1dd8f47394f417),
        bytes32(0xe5718bdcb1a5074c49f93470829fae4f2f5aafd9320de6b43c23701451db1657),
        bytes32(0x393447109f261353253cf0ba07105171e0d21a5cc52ad46bec4a490cf7726c35),
        bytes32(0xab66227444f197003888a65d05015f06b2f7567c2e3ae0ee3c1967f6e41358c9),
        bytes32(0x1390aefcc927356a8e46bc74eac018717aef177d45c0c5338df98eec77b8bd40),
        bytes32(0xbdd2bb0d477f15d3b7bc30a66ab1521ccdc8b72668855a22b4d6b73270d968a1),
        bytes32(0xed71ce41510f7153c169b5f528ca22a8a964603be4d32f60914c5d99687487c7),
        bytes32(0x2062a7fffe4724d413bbfb8fd3b86e1ca521ec7890cfa1d97580537344de384d),
        bytes32(0x856b953d3cd724a13352ac4d738db08f1b0671b448b53d83db4e71ffb040a90d),
        bytes32(0x0d12eb68d65323b68e808ab81833180dbdba4c499e8e3680f077a84de43781a3),
        bytes32(0x58421e3dceed0a70a41aff071360107cd613214dd65d8e664d6aa2dfcf0e8295),
        bytes32(0xae39dd7aa2e983601a580dda8454fb51723b82aecd26ff4fad730fe4c4edaaae),
        bytes32(0xeadb6da5019d4abf0e86f28025ebd321456bf8dc56af7cec205ea2a677e9aed1),
        bytes32(0x8bd6c18b9f80191fd570a225707343f78126570e0dac6792f94e4b8cfebba423),
        bytes32(0xe6169f982b2555217c49bd3acecc3f5b3ac9286214f675cca9238178872d633e),
        bytes32(0x21059aca0f900fe9e92769c31bf19c163e0266d2a42b0467f97533e4e73fff95),
        bytes32(0x9346568f6a7a2dfc04fb1513cafd3a3713687ed1734328f9588b26f033e5d47e),
        bytes32(0xd003ce87f911e17a2802c604089a1f68a4dc8b96e819b28a8276ce6af93ee2bc),
        bytes32(0x825e34730479b4069dbaab131b3b15721b3142eee8e1025e9d48d82aa6281e10),
        bytes32(0x028a66b07bb41052ae21a23d0c5f178fbcee5660ead63eb31e4fe9c16a126920),
        bytes32(0x5490a0579f109ed3c7227045ac7ca08513e7393e99ee8ff2e19de8b1762dd37c),
        bytes32(0x80259eaee1d0359e813c2905a2f6455088108e09f63eaca64fabc593dc5f8840),
        bytes32(0x4bb5333fc27760065bda6e64852ecacbac3168c455a68ab255a2e852a5c76003),
        bytes32(0xdde4ecb575b4af2db8c0b814b707c7a2d91d24a41030d7f992f7fb20cc2b5e50),
        bytes32(0xc7085a227e74fc5d5c34307b78361ebafd30d65baf5ad5a4483bf87af3aff871),
        bytes32(0xfe7b0a5e9226e970e1d652053345ac9ab195921245b00c6f50b9297ab3dcc406),
        bytes32(0xb1da973152b32042b913bb742f5880f694db1a75289bbc3c8b6c0ae91637eb97),
        bytes32(0xa3e95f4323da20e1364672e2a41078eb067672ffbc155be54d7222d276de50ee),
        bytes32(0xd20b051d5016d64fbbe7ee9f49e3872d0327139651ce627e429b04c056645147),
        bytes32(0x89e746ba51690dfaf3920e2b8a0b29ed0cfb3d1a43d36cb3e382320bd572b7e1),
        bytes32(0x9080f3268bdf684fa0f37a55e1c609ab4bac671ebc1d25d6aaf3b2f86daa9426),
        bytes32(0x1fcec1cd226bdaee4106272b4e8f0dc4914e979ce3436c7d707fc483501879bb),
        bytes32(0x069c4bbe8f04e256f66dc514a9af711ff27b01fbbcea347a3df269f7f940a08a),
        bytes32(0xacbed0f2d99f029b281dc07fdaffc211840091eee2bd0d3dda602dcc39787035),
        bytes32(0x3f4e9c837a767ff95daad56a6b796308a37ff8aa1c85cbec4847c14b1433c85a),
        bytes32(0x81c30c5dc501c99f50d4ccf45fefbf06f735dc6a28b425436efa9bcb715cb0d3),
        bytes32(0x361150151fe925d46051f3053e141c63ec7c9cc5fc10dc672220b2c0c7d91949),
        bytes32(0xe8df3e34ed6c807648c6b4f09580ae1dedb6e2df575bb690e34cacf6cb758d94),
        bytes32(0xb3c35d7ea184bbceade1e259140fffba6fb67119f077ddc741cc4d1ef7d7baa4),
        bytes32(0x25684cb4d15b9c45a16a20b901ca97b56dad428a97660c35667740630c626f0b),
        bytes32(0xf38daa863b7b2e93064b35c758362081339fba49c020e5fc62e46e908aec6fec),
        bytes32(0xa9342588670ce8880ee63f969e9bf6da4bad27259ad1a9ddf573eee92900e296),
        bytes32(0x86d763f89dce9938093f9b6cd18fca04f070519ad8fa6f1c152e2ece581c49c5),
        bytes32(0x77aaed6d366c93847c16a12de390618614bc7a811e73f0f8985009549cdb3aa4),
        bytes32(0xdceb2a17a73205a8a32e4a9260670884ca1a6cdd407b57d7603a014424a27c38),
        bytes32(0x83b69dd8ea6489450b6d986a71f74874c62c5b37df0e320041060324b56b500e),
        bytes32(0x9047ae05d6d6bb4d5c335f8bd7ce934069263e41d918ea1326a3ebe5e3cce82d),
        bytes32(0x3c55fef39a1f1192344f0b93502ccc8987df02022845e14cdc8ca11e511808f2),
        bytes32(0xec4a261104b4739c6634f4d534805ec25ca3996ea0d3d83ab63233d89632f0ed),
        bytes32(0x968ab811ffdbcb4ed8f50fcf5fd6e9b5e68aca23af23a368710e6fccc749f363),
        bytes32(0x3ac264e1285a94578eb39bb4668802b04eeede490ac4e0573d9b18b6f2432ea0),
        bytes32(0xbaa803e839a86bd81e68f75bf6b4d2a140c29e58253c33bb273e76623671d9d2),
        bytes32(0x17eabafb9f5930ff9f94f978b59ae55f43fc915b06127c30009703f2fd361d86),
        bytes32(0x3e5de9b962ba7153827a4da98a28345364bd5fec34ed75083b7d6ab1e8b73cbf),
        bytes32(0x9a4e605f316da9adc2632374bdd1428711ff3edbf817aa2be16875b1b5e14855),
        bytes32(0x6ffc8efca379a8a18228facf5716ef07c631375fbe2ffa99e5319bc9d53d004c),
        bytes32(0xd6990c1c8fb285f7ef4a14dfdc9b00f748067907040d3abde35d9bd8df59e37f),
        bytes32(0x65c999025740fdb39c29b423685c6b4669f0eb718a978ea8e340dcc3519d895e),
        bytes32(0x978e94c0cc5398ac7dc841565cc67b57129a422faea0fbee734130b6653bd64e),
        bytes32(0xb9144567d1d168c6398c6a84626d640318053b26146bddd9a756dcfcae2c8c18),
        bytes32(0x40c4d46b684a51f97a8ffeaaac6b3fe0448ff1158b069dc77617003b8c416392),
        bytes32(0x3beb885a67149e10b3f3eddba051a20f7966343e4c251c5fcdeba3fade371db9),
        bytes32(0x080fb260471f0e9ff19c99a45a7720d4b58bfee0ce0708188f98432a73bc650e),
        bytes32(0x1dd329b42899f5002c335a5dbef7f38f848b7a9215d6ab2c7300069b00177978)
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