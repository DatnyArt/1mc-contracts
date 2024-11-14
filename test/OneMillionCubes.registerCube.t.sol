// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesRegisterCube is OneMillionCubesCore {
    enum CubeType {
        NONE,
        GOLD,
        SILVER,
        BRONZE
    }

    event CubeRegistered(bytes32 indexed coordinateHash, CubeType cubeType);

    function setUp() public override {
        super.setUp();
        vm.startPrank(owner);
    }

    function testRegisterCubeGold() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "gold")
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.GOLD);
        assertEq(
            uint256(cubes.getCube(coordinateHash)),
            uint256(OneMillionCubes.CubeType.GOLD)
        );
    }

    function testRegisterCubeSilver() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "silver")
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.SILVER);
        assertEq(
            uint256(cubes.getCube(coordinateHash)),
            uint256(OneMillionCubes.CubeType.SILVER)
        );
    }

    function testRegisterCubeBronze() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "bronze")
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.BRONZE);
        assertEq(
            uint256(cubes.getCube(coordinateHash)),
            uint256(OneMillionCubes.CubeType.BRONZE)
        );
    }

    function testRegisterCubePlatinum() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "platinum")
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.PLATINUM);
    }

    function testRegisterCubeDiamond() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "diamond")
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.DIAMOND);
    }

    function testRegisterCubeIncrementsGoldCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "gold_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().gold;
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.GOLD);
        assertEq(cubes.getTotalRegisteredCubes().gold, initialCount + 1);
    }

    function testRegisterCubeIncrementsSilverCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "silver_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().silver;
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.SILVER);
        assertEq(cubes.getTotalRegisteredCubes().silver, initialCount + 1);
    }

    function testRegisterCubeIncrementsBronzeCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "bronze_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().bronze;
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.BRONZE);
        assertEq(cubes.getTotalRegisteredCubes().bronze, initialCount + 1);
    }

    function testRegisterCubeIncrementsPlatinumCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "platinum_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().platinum;
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.PLATINUM);
        assertEq(cubes.getTotalRegisteredCubes().platinum, initialCount + 1);
    }

    function testRegisterCubeIncrementsDiamondCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "diamond_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().diamond;
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.DIAMOND);
        assertEq(cubes.getTotalRegisteredCubes().diamond, initialCount + 1);
    }

    function testRegisterCubeEmitsEvent() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "event")
        );
        vm.expectEmit(true, true, true, true);
        emit CubeRegistered(coordinateHash, CubeType.GOLD);
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.GOLD);
    }

    function testCannotRegisterCubeTwice() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "twice")
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.GOLD);
        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.CubeAlreadyRegistered.selector,
                coordinateHash
            )
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.SILVER);
    }

    function testCannotRegisterInvalidCubeType() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "invalid")
        );
        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.InvalidCubeType.selector,
                OneMillionCubes.CubeType.NONE
            )
        );
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.NONE);
    }

    function testCannotRegisterMoreThanAllowedGoldCubes() public {
        for (uint i = 0; i < NUM_OF_GOLD_REWARDS; i++) {
            bytes32 coordinateHash = keccak256(
                abi.encodePacked(block.timestamp, "gold", i)
            );
            cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.GOLD);
        }
        bytes32 extraCoordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "extra_gold")
        );
        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.AllCubesRegistered.selector,
                OneMillionCubes.CubeType.GOLD
            )
        );
        cubes.registerCube(extraCoordinateHash, OneMillionCubes.CubeType.GOLD);
    }

    function testOnlyOwnerCanRegisterCube() public {
        vm.stopPrank();
        vm.prank(user1);
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "unauthorized")
        );
        vm.expectRevert();
        cubes.registerCube(coordinateHash, OneMillionCubes.CubeType.GOLD);
    }
}
