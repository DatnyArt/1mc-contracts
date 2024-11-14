// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../src/OneMillionCubes.sol";

contract RegisterCubes is Script {

    bytes32[] public goldHashes = [
        bytes32(0x51041b7cba898fb39adfbd2919c4222fd742d8ef1210a5a64ce8602c3ade7f02),
        bytes32(0x0c94007d5d76f2543cd50b205a2f8a9c40212be45e376723e9c494c8cda7eee2),
        bytes32(0x542343b56d1d1933ebe9b72928ef65f5501f32bd969ea62fddc8216c7eb694f9)
    ];

    bytes32[] public silverHashes = [
        bytes32(0x3fe98c0a2c9f23485f411de74b66963a8d316dc4ceba19d5d4fe275b50c21737),
        bytes32(0x8c9293a94a5705f94bca62792e3fe8a97d55880f824465534e4a0765ec1f1208),
        bytes32(0xebf84ce9a56ee72d258140d3b407d21a3d31dd2217615d091b0491910b222921),
        bytes32(0x38a9b117e9dd0d6aceada8ae6b2d37920b9aded39a762de416cd5e9993ef2b85),
        bytes32(0x292c404c34c15cedfd2eb18f893cd9b67d786dad2424c713fa1a68850d69e634),
        bytes32(0x9980b5ab3322a90450c0d3b6c6a936e8944b076c23f916891399116630a9ab32),
        bytes32(0x661583dc31a02522ad00e58aa5de1870eeb89102b526f9c03d15a90593865b50),
        bytes32(0x96aa0c8e203652f777d7d57cae5baba7878560b06e32a5fee24dd06c3b013825),
        bytes32(0x4563142733f0cf02145e17d0cbb90596cd6750a53f3e42259682c9361ff2fce8),
        bytes32(0xa64735862ab4a46c9fcea11d21fdee3b4782f5ff0a764b70e3ba9e84bf63c8cb)
    ];

    bytes32[] public bronzeHashes = [
        bytes32(0x09c3b6a70a15d495889d587da67e0720d9f96bb38fa8b8e7411b3d204adc3554),
        bytes32(0x6c5c1c2f7f29336a30d1f0dc922e382f58fdf84dffb00039bc1a988488e93387),
        bytes32(0x159cab4ae9dfc54c12ac9a86391d2037b4f1bda2a0533b4dc75408fcab81a71a),
        bytes32(0xb11be1e7118761762a96d698cf426936d5458c18250d534d4434ff2fcdff74a0),
        bytes32(0xa6da2d4e73bcb8e1c712ea6db5feaffa11f3aaa1b29d024fd3820ac38e3f29c4),
        bytes32(0x3ddb924c245cc6569861a1fc7a560148394c3ee5e5353803c2b7129ce5d9e6be),
        bytes32(0xe87f87dbd5f67702df1d0bd4356075b56e4359a40e4b26216fe067935b2fca67),
        bytes32(0x3ed23d9ddc853aa2f3405bb6991b83ba0a48d4261d79229a7d83f09004e99c77),
        bytes32(0x9823663681c3009a9ee198fa9c8964cefb5de8c1b4b8ea7c3e9cda9d62bff388),
        bytes32(0x5f9eba9fb5b17f7835e0ed43b6f6fb31818ad1e93523bf64bcbf3c0e41fe19b8),
        bytes32(0x42db0a66745b6986777953c7b0ba84e9619d9150fb414af3b8f5ea980ebed24a),
        bytes32(0x06d618a64c8355c1a0b16d989e4703087a0a8125861743ff7329d54fc314f954),
        bytes32(0x4c6e40fe83929b04165000cb54e3d8c492bf40c88086982fb48cf83d8c68b2e5),
        bytes32(0x9a346b1087bd0bd9af8f72f8e6cee63e0f51a17a7119e5ec9fb0d6ff93719ec9),
        bytes32(0xfd06da99bd6d4499684ee1b2d8b1719ebaf15bf740f084ce0c54d076c5081edd),
        bytes32(0xee83f91d403525861534856e9cf70322435c908aed55a53e0444ae4f2a4fc3b3),
        bytes32(0x6bdd96521a289a28a149eff3e8e8ae141481453df47e81573aa9899a007f9c77),
        bytes32(0xf88648288f44af90b5335bdfbc6684e169cd29e0759581652bcabd60d0c32c97),
        bytes32(0xf41d104f94140453b168486365c2f480d78e8bf67143fa067d0408ece37cb5b2),
        bytes32(0xfb88e0f8d5e86b5e171970e5a6de2ad18f9cdce3ef9b81cd56469a585450dcbd)
    ];

    bytes32[] public platinumHashes = [
        bytes32(0xcbaffed1a148c4c877e9359defe59ae48720d5b66034b5572444192dafae59e1),
        bytes32(0x90e4085883c2b2e58ac11890fee5bc4e92cebc44c8931901b9448ba35bdba02e),
        bytes32(0x9f5023d8a625673c1ef690d2e399cf8da3d3f5f386c6fcbd3339c73715fef03a),
        bytes32(0xd65b1cad48c5bcc3919289924c58badc60ad715dbc06c0fb3bd1091ea413e93c),
        bytes32(0x81497e1cba5d46c1537faf05a36d8332e0504b36ee82db572ba07328f44340e7),
        bytes32(0x425424132e4c4ded7bc1e8293de7f496ae90cb88a731979868d62d174695306f),
        bytes32(0xa40b17f03df14440d3bb4da3f700c6193f6eb896c9e984974f8fa23a49d8564a),
        bytes32(0x35ba985344021c00a181c77f21b77fa05fa9eb03687fa5d3fb9460bcea5d0824),
        bytes32(0xb7c2e1ecda367afba9bf5659668a8e122da0575479165b106ec331bc4d6b40bc),
        bytes32(0xc959cc5f6fb61ebb81927f394ed47279c32140365f3151885568a80186fb00e1),
        bytes32(0x13989a5baab1a71df0250da5996b3c0a83784bc5fb195ed487d3c29d0cec1a35),
        bytes32(0x53c871c414e7c7327fff2ec85d6963af3b8443a3d9f48ceb52f7b2feeae1e40c),
        bytes32(0x012e6435f3cc20641cdac74cf03c8c77ae190c0de334d9839fef5db27e6f6d9e),
        bytes32(0xb33048757bb7ca53ff92385f04894d3649d52d5a963e3e52bd04f22ea395f0bb),
        bytes32(0x10fa6b3c6e355b43537bacf894ab9749745e780e4c90b70d8b478b3c3c0563bb),
        bytes32(0x7ed2728081b962bd1704a2ae0820775a61d5e75d2ae592c28fb372929b8a2335),
        bytes32(0x22b70424f5259404fd91b8f50ee5fa6de662cefd855ca7f2413e428d526d68d9),
        bytes32(0x44fdd510458145432966e388a6a81d53514f950293885ceb70a21d5b8d66739d),
        bytes32(0x4de3c838b2086f3f7de5ab545e496448aa7b4ef9027681861121ab60066438a8),
        bytes32(0xe8f388f744ae7adb04943eaa7cd34607bc9c6e9275139f60ade0598901790f78),
        bytes32(0xb40947c2527bd96d92fce46d02205482e0d22fe9838d3e0338a29390dc6868ea),
        bytes32(0x4b92dbc4ff0d1976607d9199abeef0384c437f7c6d62baf2a763f5c76569ee2e),
        bytes32(0xb1d04427e3846968ac920ec3ebc9ea1253d97ff0f2e773f1a141531a7098f020),
        bytes32(0x6414d602a8fdb414efbf308fcf359dc5a2ca55f4724bf2d27d1502e6041f16a0),
        bytes32(0x80ed9d08d6df6eeedea516346d9a1b9634d9d21942328d58606e4e595bc21325),
        bytes32(0x79aaeb54fa5e1dcbeee7c4821e078277f33d681a2a54ccc209345861966cb7db),
        bytes32(0xb08da82c6bb3671cc90dada8d25f72cf6e598b737a5f6f5599890d28daa0b448),
        bytes32(0x3e3699efe30a85a02e2d1c9513a358229f66a596c40e6071f9e74956b89790f9),
        bytes32(0xb9bf0fe97c5dc682e663d1840ebe4c4848ab263e54804b4bc1504da4e76ca9e5),
        bytes32(0xe05946e55e51ef2de12a3ad9abe3401076abef8e6cd7b5a3be76688814465eff),
        bytes32(0x54dbeba5d75dfbdc5ec93db7d867d599f02299ffd506423ef9adf7c40708b873),
        bytes32(0x72940367462c0dcde08974252d66081728049440e3e292543810065f68bd8425),
        bytes32(0xb728a3ddd7234d4049409311913ced62064e2d54280fe4e93663ff05a892d7e7),
        bytes32(0xb08d548a5dd532d0d3685796c2f51c9d13dcef3c0714852392c9fa0edd39d827),
        bytes32(0x75655e08d5bce397eb237731f57d0645d11dc30d4866cd8df613e80fd4f71241),
        bytes32(0xb7e1ca7b255c57efcbe62617a888e40826f5a460adf0ed535b6b5f57636d50c0),
        bytes32(0xa8f5a5cf5dae8924a8f52b9c6c0e48c025d012b6c5321eb2485a5a9ced3b85d9),
        bytes32(0x5d941579522fa8a5cbc6d5ab8ecf7b4034e191399500dff4006f5d6b12452478),
        bytes32(0xef1c250708698e3a2a707c5d7e741fe7586f02c3f4381eafc1ac771b25913add),
        bytes32(0x6ed687d0f9d4bf4dae9b4e499530e046c6ff4719e547e50ea47e4c3487440489),
        bytes32(0xf40361697100c7467d9fb78daf5da2c869aa3cbc3047dc8260445d46b5f4e659),
        bytes32(0x0b8a4542df66ca1a14bf8a204f1f1287f7f1adf2a3f0fe94c44b572debf1ce5e),
        bytes32(0xc84083e8be4eda552766dd154e8bd8cb0a0102d59bfad6a3b2215e013aa202e8),
        bytes32(0xd656321a5d8cdb843bb50f81dc2c23359880cf0ccb086f296e4395e3356dc04e),
        bytes32(0x94097e8187531fccb4074c1cea851fcf3623989e17c47e0ebdd574f8590c4fc6),
        bytes32(0x88d54e1ea0192da59cec0fad57d7b98b21dbfa40c650908d3ce8917536a8c644),
        bytes32(0xa5b5f6d99bd236e6d070ab9515b30112efe146e984aac33c126cce053051f476),
        bytes32(0xd2a30d0b770274878b88f60191f1db7140d48e42e747d200f9733c52a4a09af4),
        bytes32(0x0f0a73a0e922ef4826d3e86cd043b921c210ffb3bdc513528edbe7916b648fdd),
        bytes32(0xd53ef1b9708a56dc697f42f6a8fce477264a7a4ad73d0a50d36cebb7a845b5d5)
    ];

    bytes32[] public diamondHashes = [
        bytes32(0x1a15f022f71bf927645e4f30bfa9984f690d5ea23eef7344232a9311ef5d0236),
        bytes32(0x923a8fca76d664f9dea35f98a44a8403cc4861031f37cef0f21f0da76fa45f70),
        bytes32(0x797bfa069257ebba2ce0e6a373da19e9f0a5f22f18ecf216d19b56ad194493ab),
        bytes32(0xbcaa5fc425f72237726132eb37d3b12caa8be1f6fc27cc257e1e206b480adfa3),
        bytes32(0x44911f3c7c556cc7145822f485b9e85895266cb2bac9c8fb8c93ed83caae11a2),
        bytes32(0xf9fc0291ffb9010dcc8cc71f3a3874ad20e90bf38153b122cb542f41990d6731),
        bytes32(0xd0dd4db30b075df330f67244c701f0b6911fc4808f8ad8197539a8e1bab3d25c),
        bytes32(0x27303634eeb68e11a7bf6de76b33f5e99b0da60c546d2149bbee5c5889551fbc),
        bytes32(0xe81e71a6d74506e108ef628cdda31d982446bd773871bafd5adb06bdab10f369),
        bytes32(0x9c8587e44b82a015226ca42234882abcd5e52e1557a1db6903d4be2d9e8887ee),
        bytes32(0xbae247c09a513e8b45bc1126a8367034d9b95b73970c64d20b2fb3f8fe267d95),
        bytes32(0xf65308df11a0b724affac6e82f54d2833d97654b9d87d005b30239ec96cfb2dc),
        bytes32(0x9729c5e092786f773f9e4b071233d2b8ff4358596478224bf696dcd1079335dd),
        bytes32(0xc375dacce77f1d5d80b37dc6840900034a27325830f8f73c9e2311fa498bb512),
        bytes32(0x631066e4a3256db69fde92136abd787fec7607f123aa011505d5a722807aebdd),
        bytes32(0x2b78b77fb78d84697baadff0c2f7800ed680977d22c66a1a823f848858f6aaa5),
        bytes32(0xd31d2a66d1c9b2d42559c4a6bd6f5ce3078998c2ded779218fd69086db2c0746),
        bytes32(0x94374a4d3d4e56cadaa854b4f467722352fd04a08cfa3c616b8488d28fdc5e6d),
        bytes32(0x72e1e590e32b20a8901320da6d5d3666237aee99f60cd0da1e23a4daaa704fe2),
        bytes32(0x221f253afcc51b598b051c6d8429ff7fd54ac2590e56aba38c0db2d191652a1b),
        bytes32(0x0c9c022a2c10a53e88312b11b7c553ad7a6220387a8a63b4943b565008ecf11a),
        bytes32(0x81b95a724c76311394721c024f0233b67c829222faf542e7409ad49b3ffdf4b0),
        bytes32(0xa740f488aed817e6351f7045e6d56bad78eed8cee2b2168d839012fe69b4f1f1),
        bytes32(0x3917302e834f2de9b766742987fb425b4544fb8d46fbf3807d067e05dd57d361),
        bytes32(0x61ab246e93f50660e3a5b8b3df106800f1c1c503d041794ad4eef85612581cc2),
        bytes32(0x1552b1ca6d380bafd92155d0dffed8713984d35e7755a4686466baa72a3d3c11),
        bytes32(0x92f4f6e40682f5f8d0fa8c110b9f40e93089d69942a918a46fbb335093d77b0d),
        bytes32(0x55b9f8b235fda3b21ba382101fab1989f408bb9b17a06fb7e7e6cedc3a866297),
        bytes32(0x0ccd74527ddfd7efa8fb84eceb9dde4b6e5f342ac3d80b4eb079839b01a23540),
        bytes32(0xe3738fc7902cfab4d4687c39f2b6641d178a15acf6e88b09ab9c8f512a5ff64c),
        bytes32(0xdfc553a629df0eb4337ab128ba8a0beff64605ba3df87c933e701ebf27f3dbf4),
        bytes32(0x10b4d05912931f3eb56c233d924b63de1f618d52a70e729dee9d965a7484aec9),
        bytes32(0x9b7103021dccea6e00e81b55906706bbceea75495fed86f6795ee467b65181a5),
        bytes32(0xbfef38e544dcfcf4c899e6a407cdfaffeef182210fae4d6d9837edea9f62f82d),
        bytes32(0x440248cc1ab3c72a645a01060638f16a87a3dc9287cbe6fd10080ae7130dc07f),
        bytes32(0xd00877903c937e4d2b8a6c0ba57373ce23808c1e6490e6c07568e4b59cb8ea12),
        bytes32(0xf0edea1df256d26eb03a93acebc89cd066d3a39a18646eb3c6463fb5de651865),
        bytes32(0x8ce71ae7f77627cc5c2d87e57d6e2130afcb3bd75d1a048dc38e6035ca53f323),
        bytes32(0xe51f5dba3234f047cf49ad5fd24a42be9ccef1ed77ae3253fd86585f3c386c57),
        bytes32(0x56822a9a168f19b1c3ae0d9a854b2520fa2ce1b22fd659439d64df2fc5ef1cec),
        bytes32(0x22194de01b6f06993b373a94aac1411958d2829682a563879bb94b29a28d7e91),
        bytes32(0x9f0102575735503017a5ef1c9a06400b692093609f38a023f8a1d23362e68493),
        bytes32(0x29423f98d0d03747b957469f9f515be0156fc63a29e96f5307c7be00bfcba7f8),
        bytes32(0xb09f64a76b20b1ed2d34cba085be495f629614dd521281b2f6e267b70a4eb5e4),
        bytes32(0x537ddca57cd0060e64fb00692fd6f9fcdaffa76ac99aba635186ceebb54f765f),
        bytes32(0x4337cfc64f4a580a464dc2f51ca69f7d9b996138e986ba124a6a2714ae0c4649),
        bytes32(0xbee7d66293b4540bdb6bfbdd880c750d0f1b6a9741b78467f595a678e62ef072),
        bytes32(0x36472ff438e469355d0eabd3616df453e48daf556076d3df21cbd80dd81acdd5),
        bytes32(0x0952756b3e7bb267b37e14f864ef9e46eb17a3ce62b8d7dae28e53ab1cd52994),
        bytes32(0x915834ea8e709a169d67157cdac2e3a9a4b2a4657464a7618824617c6e51df03),
        bytes32(0x2c0be9d757b16418dcf078eef8323a566826da09555365081930a6952597c76d),
        bytes32(0x12239d54df612e058c2605bfd81991c940e0ea5cf95000f9020b027de40d38a5),
        bytes32(0xebd8834e96f205fe546b44738fa1b4d45d8e63938a6a9b678c560535c98047d4),
        bytes32(0x11fc916dfcaa15ba61514ad88daec15d55aeb994873b38588447ceae0f4d3182),
        bytes32(0x8b44c496461a31d4d8159ec23739ccc5ffbd2cabb2b8c3b991a43e92164bee97),
        bytes32(0x1a1c7dad3ad0fca75df660430d5021c56dbd1b4e863716cd895109a8df9cb987),
        bytes32(0x49354d3f2393d1795ff1df9f70fd169f1de29db14fe6016c5fc85990aeae4672),
        bytes32(0x40fd6e9bf45c3b4a5ad00b1a4f8f0b3d2197891d563c82b077b9818aaca84615),
        bytes32(0x0c0dd44a79fb6b2bc3d408b6f6f7b6c483ef6f167fab969e3768241474bf9dc2),
        bytes32(0x1022805cd57c17415c04679c1028303c1c876f8af1df9b8ed1fe6ef1458f4cbb),
        bytes32(0x71d35fa943289c53d3d07f73932bd574972c7dbdd51e8a789113c04a02f3a686),
        bytes32(0x8c140186eff901470ada6b32933a64bd075493d05d51eec259202332cb3d2052),
        bytes32(0x01ec8f2c56c47deb2550c2f3d9d256a7b25e5bb4b4e57b8bed262814c3cf5102),
        bytes32(0xbcd69adb493ff7fb9fab9c2d0aa888eccbbad651eb082117b03f4f26260ec328),
        bytes32(0xb7e60a80c24a3edf22f72c8f6a008b1d25b7020af1cf9657c83c9e4d9635f2fc),
        bytes32(0x3ff014f745875c2a4de42b8da98a3a52e83d0c16921c1851e4d1aea5e2ca4e0c),
        bytes32(0xe711d76742c906b809d84ec7b5dd9d4b11c6857b58ea8494aae83e636a58f0bf),
        bytes32(0xb2c1cdd2319409c2dcdca5bdcce7f156f7fa230f8c29cc3c5bbc912ff4929dfc),
        bytes32(0x99c1656334ed6ab8baf195f92dbe842a5fcc105b335accff654a0bfd5b45890b),
        bytes32(0x9cf0f2f26eafc5c5f5aa1ae740b204609bb4acab691ac4c8289867b26bbea28f),
        bytes32(0xbca9682530a000de36a8142a649c4e615fb44a45e40b13461eeae954b7619180),
        bytes32(0xf285d8a19daf714995b8c23482dd8382642a5f361468ab915731f3eb1beb677d),
        bytes32(0x00bde3f1531000b1d122c26074dc40605f18f66d9fce2496d54c2af6280f823a),
        bytes32(0x064e18b96742b601d759d2dde278f2193f3e454502c63244b0542fa9798cf19d),
        bytes32(0x0d23978893b6b1e5d7105a3fb2c90b85d46d9a8f3425c8bb401b951d2da2dd9e),
        bytes32(0x5216d1c68625d0ebf47f839bc602984a899221288f16dbb6c1e2729509788e51),
        bytes32(0x59229d3eb313349f15e04976141386ea2abc487af980a3ddc97cd7a73de17294),
        bytes32(0xf68a666d73b2c31bd1d7c97026284ca81fcc031475f35a5c9766d0c7e92ad59b),
        bytes32(0x69521e9e68f00c9a955db7dec60ec7725068ba6db7e639496f4ad199fbf1b1fb),
        bytes32(0xa111427a8fba40216e06b173fe245ac36a93853efb880be7bde6868ab1e7ee44),
        bytes32(0xcb6080e66d291ee5f2a6c69f8460a6faecf61755a9076db77e0730051b638e49),
        bytes32(0x71a486dbb6a5e9577acef59b59fc3153cdb397f401a5e8f96796fde6e92b2030),
        bytes32(0x2d8d5cb5c74a41df1c6f450bd4f6a8958ad212ed061338cf9a08610f87feea7c),
        bytes32(0xa14daae37fbcd23e69de9d1653cea3e5d7c6d2dc20ad517943a6ab38adfa1247),
        bytes32(0x20695806ab5031726d85ce29d381f37794e4f8b709f52a723788fa6d25eb30dd),
        bytes32(0xed8a4a999552e77cd34390a0676f44d868e6a05ea9964ba583f601ab0b5e771d),
        bytes32(0x8a9f6384778b4d5572182ac008f472221b44181d61ccbb39fe539dd10b9019ce),
        bytes32(0xce81ab2e36106c1a64f738c862cac1fed9ce5478c758d2f5f5ef094a54d4ffad),
        bytes32(0x693318fcd2fd3b909de77bf5753bb0860d109d4da559ff4be8de8ee67d0837f2),
        bytes32(0x324b7e2e244bfcae8fa57bb63ae4d5b5efbee25415481c335000f556a4629856),
        bytes32(0x236df5a9f3aeded968a0d93405fd5c02e1017dcc56e8e30dbbe05ede7dd2e846),
        bytes32(0xab5e05a8d5cf11a9e9b2ba8cd87516bd48b7cbeaaea402b74fa613bc01ba0f43),
        bytes32(0x5d548538576448483a6b4c74de6254598260ef243e5b4dc26f2892293978a304),
        bytes32(0x70dd1ed19ebc255c5a3d536ae68a523ae27f5d5885b614641c0ec94e569016ec),
        bytes32(0x7182213159b52a19cb1b23e21eb3cc06a7864f5735a10cbc8a890a91daa917d8),
        bytes32(0xb64d10c67563c2e86d188ae72f4cc685f2147fa2917e187f936bfd7ece87ce7e),
        bytes32(0xe38e2d6922a41d5383463cd3c389916343f733243612523c4efa0956bb416b42),
        bytes32(0xaa09b0c8bc0f460424d186c4a949493a41239ccbb31a90857bd5f0f5a2ec1d2c),
        bytes32(0x2635c17796ed7957e778c9fd69fab54fc70e43f7f175aa6a8f6601808acd6110),
        bytes32(0xff60f13dc89f71119f2695cabd8d3bdbbe6acee5f2e6daa3ac546a0b6d8a3e23)
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

        registerInBatches(goldHashes, OneMillionCubes.CubeType.GOLD);
        registerInBatches(silverHashes, OneMillionCubes.CubeType.SILVER);
        registerInBatches(bronzeHashes, OneMillionCubes.CubeType.BRONZE);
        registerInBatches(platinumHashes, OneMillionCubes.CubeType.PLATINUM);
        registerInBatches(diamondHashes, OneMillionCubes.CubeType.DIAMOND);

        vm.stopBroadcast();
    }
}