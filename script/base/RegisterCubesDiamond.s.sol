// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std-1.9.2/src/Script.sol";
import "forge-std-1.9.2/src/console.sol";
import "../../src/OneMillionCubes.sol";

contract RegisterCubesDiamond is Script {

    bytes32[] public diamondHashes = [
        bytes32(0xf60b7052320faa77c0b241294b7ee866e47e52f26b59e785c1fe445edc8f2133),
        bytes32(0xce21181d04bb48f0ed6028e0beb26cc6af1cfd78a04f796f7c12cc319c7caaea),
        bytes32(0xb7bcc713bda0918812451324af07b67c4461cae07be60b3e3d366e2788872946),
        bytes32(0x1f514a7571adfc7232b136d72b5dbf67e972c8598f834e9fcac65e8cac3976e8),
        bytes32(0xf17d10d87bd1cfd655d470e2cb23049707d4469908fead09e14b2187c54c6ee7),
        bytes32(0xae9a4183f34c350f26e9ecc922251b1218dc2c0d5d6690a8c8e0cb5ab39f3588),
        bytes32(0x007d486f747662c264cbda0c561287d8631be1d69b6f8757b9fb8fd774823dec),
        bytes32(0xe518775f764743bc3f1d771617b82e9124e8394a9117eb21bc5730ee46facf52),
        bytes32(0xdbca6ef990429ab761ca09141d881e0d29d77ecf44c4dc9378ceb6765879ec4a),
        bytes32(0x0f69de01bb73dd400d8dc4fc5b559039646c900f5092d63134d82b5e502c75c2),
        bytes32(0xa5e722c8d02eee641f2299cc52d6f4a768adbb3c9d0bcd1d8d77183e0ed2e90f),
        bytes32(0xe439156979d7c8f66ae547605265b26cdbcab786fa2fc2c9567e247120bf73fd),
        bytes32(0x131940755daf7c7b7ef8265387bd93535ecca1a590428906b0a4379e66e9ab1e),
        bytes32(0x28c576b49f1b2e2b075b29575fe721d5e1596cfd8e2083d7b62ea6cd07e5d459),
        bytes32(0x4b6416dc7bff3143d0dba5a56495a0a5cfb5d169f3883d7aaf2cdefefd9177e0),
        bytes32(0xcf0b054267ff302697ecc25c3cb869467cff1435cbaf9f2189c536ed1bf46afe),
        bytes32(0xa9a0a5af563ef74646e8ad61d6092b5c9894e1340ccf4cda94e34c47b2993342),
        bytes32(0xb3a7e1ceccbe72e88fa24a07bc1b622b8c9e7ccad559dd50fe441caf9289acad),
        bytes32(0x1f5ce555d56d0d6f2ae064e62f0182ed789a22f7f38d5e72a852def1556d259e),
        bytes32(0xd2082adeb9296f8565a04a9848ad42db85cadc1a649756d6087f4c012882fa61),
        bytes32(0x1bec44c6fcacfb83f65662a755af0bbb81169533cb6233097074f9f624e00d48),
        bytes32(0xcf1fafb5b7a6c843ffa65446ec21e614b61316bf56eb69a3d19eec9b47c5a5ca),
        bytes32(0x34e93baf0a5bb903089cc8747f22f88df43e9b40550d9593479ab0fd6b2d9e97),
        bytes32(0x4c05b4162ac2a89023bed38f30af00ac015fafffc181db6ae68d520419db9e30),
        bytes32(0x6999fd6d8c4a949d5786c8ee36f331ad0bf70a591d73eb1f958852541c16eb92),
        bytes32(0xbb9b9c6a36ad059c1735a933ebc05438af2fbccb451b36965f5931b6b00f376b),
        bytes32(0x6853db938fe651de89c03da8d2317ac8f330325672d901ade0546fd845f85c04),
        bytes32(0xa4ad3b7c8e11e6d056d9ef4279408e136516d477aa173557c168cad261816eac),
        bytes32(0x3274f6b83d6c4a6dd589443b30de2c323c61bd7e2989b37d133d1e349166ecdc),
        bytes32(0xa79a92642a567bc2e1f303561cbd5a774adb4e3024f684e3e41d789f6d497d57),
        bytes32(0xda9f72d4db2a9761446a3dacd8ffa5bdd8264caa9571a84832c8775314f91d3e),
        bytes32(0x40e50fabfead82e0a4d2ec1bd648cf96ec0cdd53d7dd704165f6194ada752426),
        bytes32(0x70f3a36cb0a0632c8608189218161b5c496684df5d7fb27d67c6a725005173f6),
        bytes32(0xd50d1965266a49e199ff426313a5e300a3bdb951b40cc7dab30fd2668a7ddad3),
        bytes32(0x766efb15c206d72c674ef61c363877efd24a4d2600bf3765b0803b5f9a11b2b1),
        bytes32(0xfc6edef75760e4bfda12fd37fd3ae76ad829e8e97de240a1a64ac07b35d24cdb),
        bytes32(0x1d4966970d9e83969a2f39ebf51bf6b040d81aefaca8ff3fba6e57baf025b528),
        bytes32(0x8549c7a1c132a1348706089126c90395b93f438baf92f500d415376378ff62b1),
        bytes32(0x4ad95ca5b9ae2cc6f7eea25b626b592d9acdbaab34cf38bdaa4b390a9caf2ce9),
        bytes32(0x432026bb86f09ed2599522f9f96669fe5dc7414e377c025278b8db9c665316b5),
        bytes32(0x45449a50af61969954f91a3d4acd0ff6b1f973e3e4f0fdd73a9882c37b34c7f1),
        bytes32(0x1017063e9566ba146cade278f3554fecfc19f80d1b58377423e0b88945c8c487),
        bytes32(0xd40dbf7f9100b12580f463915e42043f6aa840ed9592737dba55b4317e1bec99),
        bytes32(0x659f36371e616c06b7e74a31c6757a72aa7893472e69750bf8a2b496e3112128),
        bytes32(0xa9709fe82124824e8c3fe84a4593b9555379e9c6c6fe000b7bfb3ea0d70ea1da),
        bytes32(0x5c55a709c5fee9d902ab2bea3b8da7ec9525008161e8473733fa7b05b06f4d5a),
        bytes32(0xa26c30e35a2c7a9582566d87ffa5f0798b841bf60ed4879cc5bc1dce69064063),
        bytes32(0x83fadf27ef34c8842718560636a2df27c6f06a1d964f3761b48039201bc5786e),
        bytes32(0x386a09b527f1f42a2b2debe03ec04846ab385ad98bce13086928f298a5500cde),
        bytes32(0xe35d1e97cc5bdddae3e2eeaf0a13503bade1852d163d9c3c9d296343d880f468),
        bytes32(0x61f8a7fd4bd1757868fd2e3bc7bfe17ce6672b68424c6b2813dac417e86e4ef0),
        bytes32(0xac3e8b17608ef0ffd7356e0e96dc3c368abca100f2ef863392aa96ecabe47685),
        bytes32(0x884ef4ef30a92c4fda13bf71990d75dbfde198839237dae32fb61e8c8415e4e1),
        bytes32(0xbd258ec05bbd74a2b2a82cc543a64577edeee9fa100713fef31bc1f40d34cd3f),
        bytes32(0x55a9f910decad35efacc9e3f04e03d2c7fc6655fdbd3141d0758eb8ccd543f4f),
        bytes32(0xca7a756ea30cef2979a8c59f74e91e7c37d4a8398b88e7742b8157b364b175bd),
        bytes32(0xc422dd28f7fb9e01a2b756ce377fb75e7fcf1dfd8f3aa4105d262f7d27b02949),
        bytes32(0x7b1092989b509a9593732dde16d42e3d810876c8b92bdae1909dddfd87b1fbf8),
        bytes32(0x72a7e6a1f2b7a3cc4497780b4a6ad1c891be2a5f8e199d608a944e1dad849ef0),
        bytes32(0x52a722ff00eacaea4900292f5121b338876d04fa099eb3a59d73aa22356dce61),
        bytes32(0x0e0d24d0c1399996a96a0fc2e54f30372337f01a7f47ad2997fa09ff6ddbb947),
        bytes32(0x12e718526e9e7d0f0f1f9a0e3a8c8b467b5c2b06bfb8c44633e1e0745e4b61f9),
        bytes32(0xc7ae9b1e38a7597dbe1083778c553471503fc03eda83f61a82cca330c806ce4e),
        bytes32(0x6734aaacebae6e4db9ad2570b98ebaf560aa8aa52cc5779bafe97a3cd186aa7c),
        bytes32(0x5e1a5c9709d918dc0b1a30a328cf38447f10c309b52daf6a6f54cf4ed6d79376),
        bytes32(0x3af6c9a1e082de3e0d5c7174136841c91922a41a046734a50f9d214bd0adb861),
        bytes32(0x4381594dc5a3c0560cbe548877358799195a42b920a634261e10585e6d04e40e),
        bytes32(0xb3b07190ac14d0f74636a5aeb2ed4c2080641cf920403bfea8cdc652fa60cc4f),
        bytes32(0xf7ffb50e45b6c0c98496f5f680136fb81941faf491d10fcb27308493de36cf50),
        bytes32(0xe49d24aff42e168f07f571ff47f76dd80ba4c861bc0cda472ad20e11d7b0a4f6),
        bytes32(0xe6ef08319e0bdad3219ad538c6f69f8c55ccf86ca51ed0c668ca489f86adbce6),
        bytes32(0x805a48d0f926cdd5af32386bf282bd4e9c7d09cd1935b7e6c86c416c938b3f28),
        bytes32(0x21d571ddd72f1cc04d3f679c7a70f52846e74162ccec8619bba886fc3289a6b3),
        bytes32(0xf08799add11fa06491a48ff0cd5813a796d829747cb48ce933d56aa1a0f3189d),
        bytes32(0x136cd047f91f65366b89dcdb446a05206b9b8404035dc9f00baca87933ee0a62),
        bytes32(0x2bc74df9739762b38cbb073a5fdf90a3fa80df6b84cbd2dc5cdac39c3a607627),
        bytes32(0x795497344af77f49b26e86845c17f358c8c4d6b28a9c8a7fc4dd0ee25624b8da),
        bytes32(0xec369d461fa34bf0ce7cd91ef6b815309a6682828fa5768137b763e3342e3088),
        bytes32(0xca4431a1ef5310c6ae888f7c6c10e3207de85f252db9415d39dc258f160ea61d),
        bytes32(0x14aa350134537ae371e176dcb43a11cb4f277a212d4f5b8025ce6941b390e694),
        bytes32(0x816c196d6e14a500c2f9563a17901929d70b3a3867c6c5efcd13ffabe76ab9a3),
        bytes32(0x9e7a336065974ad9ba54be326937a3a3298d13260ba5d6247960b977a13e87a6),
        bytes32(0x10c68a3cfcc2f40911a2c69c141297cd1704eeab3533f610ea0109a0ef40b05b),
        bytes32(0x243d812fbbed441477d9741b0ef312fa51532bc0bb5b5c162cf34ceb0068a2bb),
        bytes32(0x3ee54e70c8fe71637aadf77e6d88eb54251042d576203ca29693127b8e39b613),
        bytes32(0xd404b006494628c697ac75412f1d460b2a9bf2b4ed4cc4683323a67ecacd97f7),
        bytes32(0xbdb245e0271af77eabedb662584c0497f9b2837417201216b288f4615c7afbf3),
        bytes32(0x5301b50da05ad3546feed715bf27da5798fd1cfa632c150a4b749f07464d7664),
        bytes32(0xa0f47aa97d65fc146f5b68ba106362b90f54d215a7009f066c833b351d7866a1),
        bytes32(0x505074f01078c15cefd8810714225466c13ff62d0128310a5e24f94fc55357ba),
        bytes32(0x748b323d01a8377c59d02edf12f5555a7c5fd235034c60fdde05ee2804bf5c1e),
        bytes32(0x7e960d8fc61f998ac8fa7c7070422a8ae4288a8d66465f5e498022d77f1feac2),
        bytes32(0x8a3c4618aee9786b6b34ec1cc97a15a2e57c274a84fb8db5e2fe1e60032d217f),
        bytes32(0x73b2e8047c4b1be5d2b7b83b055e97838b04b72c3cb8f100ad4968c7b21acea7),
        bytes32(0xaad70cb0dd2bc70c26bc307132e59059634e5ff9f3c34e9f7fe722652521acd2),
        bytes32(0x73c1a4c0fa669112e01c12b2258d14f2d7978fa186b236aa59eef218a4b536e7),
        bytes32(0xd7c44760e6fae32ae4a355358e95042f1c018580b4ab3a00d71de7ff6809284f),
        bytes32(0x1bf1875552f64b3af6f74090f4e1fcdefc465b03548935717511d91170584137),
        bytes32(0x9394956006058a0a1a84a64ed89fcba36545bb67599b052f8a79bef3643578ee),
        bytes32(0xd6cc93b003c0094f9df767f502b3de2910804939093d369780a6ab59fb69f194)
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