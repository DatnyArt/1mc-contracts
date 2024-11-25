// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesCheckRewardsClaimed is OneMillionCubesCore {
    bytes32 constant CUBE_HASH_1 = keccak256(abi.encodePacked("cube1"));
    bytes32 constant CUBE_HASH_2 = keccak256(abi.encodePacked("cube2"));
    bytes32 constant CUBE_HASH_3 = keccak256(abi.encodePacked("cube3"));

    function setUp() public override {
        super.setUp();

        // Initialize the contract
        vm.prank(owner);
        cubes.initialize();

        // Register cubes
        vm.startPrank(owner);
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](3);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: CUBE_HASH_1,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        registrations[1] = OneMillionCubes.CubeRegistration({
            coordinateHash: CUBE_HASH_2,
            cubeType: OneMillionCubes.CubeType.SILVER
        });
        registrations[2] = OneMillionCubes.CubeRegistration({
            coordinateHash: CUBE_HASH_3,
            cubeType: OneMillionCubes.CubeType.BRONZE
        });
        cubes.registerCubes(registrations);
        vm.stopPrank();

        // Fund the contract
        vm.deal(address(cubes), 100 ether);
    }

    function testEmptyArrayReturnsEmptyArray() public view {
        bytes32[] memory emptyHashes = new bytes32[](0);
        bool[] memory results = cubes.checkRewardsClaimed(emptyHashes);
        assertEq(results.length, 0);
    }

    function testSingleUnclaimedReward() public view {
        bytes32[] memory hashes = new bytes32[](1);
        hashes[0] = CUBE_HASH_1;
        bool[] memory results = cubes.checkRewardsClaimed(hashes);
        assertEq(results[0], false);
    }

    function testNonExistentRewardHash() public view{
        bytes32[] memory hashes = new bytes32[](1);
        hashes[0] = keccak256(abi.encodePacked("nonexistent"));
        bool[] memory results = cubes.checkRewardsClaimed(hashes);
        assertEq(results[0], false);
    }

    function testArrayLengthMatchesInput() public view {
        bytes32[] memory hashes = new bytes32[](3);
        hashes[0] = CUBE_HASH_1;
        hashes[1] = CUBE_HASH_2;
        hashes[2] = CUBE_HASH_3;
        bool[] memory results = cubes.checkRewardsClaimed(hashes);
        assertEq(results.length, hashes.length);
    }
}