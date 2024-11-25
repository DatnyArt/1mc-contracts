// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesRegisterCube is OneMillionCubesCore {
    event CubeRegistered(bytes32 indexed coordinateHash, OneMillionCubes.CubeType cubeType);

    function setUp() public override {
        super.setUp();
        vm.startPrank(owner);
    }

    function testRegisterCubeGold() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "gold")
        );
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        
        cubes.registerCubes(registrations);
        assertEq(
            uint256(cubes.getCube(coordinateHash)),
            uint256(OneMillionCubes.CubeType.GOLD)
        );
    }

    function testRegisterCubeSilver() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "silver")
        );
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.SILVER
        });
        
        cubes.registerCubes(registrations);
        assertEq(
            uint256(cubes.getCube(coordinateHash)),
            uint256(OneMillionCubes.CubeType.SILVER)
        );
    }

    function testRegisterCubeBronze() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "bronze")
        );
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.BRONZE
        });
        
        cubes.registerCubes(registrations);
        assertEq(
            uint256(cubes.getCube(coordinateHash)),
            uint256(OneMillionCubes.CubeType.BRONZE)
        );
    }

    function testRegisterCubePlatinum() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "platinum")
        );
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.PLATINUM
        });
        
        cubes.registerCubes(registrations);
    }

    function testRegisterCubeDiamond() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "diamond")
        );
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.DIAMOND
        });
        
        cubes.registerCubes(registrations);
    }

    function testRegisterCubeIncrementsGoldCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "gold_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().gold;
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        
        cubes.registerCubes(registrations);
        assertEq(cubes.getTotalRegisteredCubes().gold, initialCount + 1);
    }

    function testRegisterCubeIncrementsSilverCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "silver_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().silver;
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.SILVER
        });
        
        cubes.registerCubes(registrations);
        assertEq(cubes.getTotalRegisteredCubes().silver, initialCount + 1);
    }

    function testRegisterCubeIncrementsBronzeCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "bronze_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().bronze;
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.BRONZE
        });
        
        cubes.registerCubes(registrations);
        assertEq(cubes.getTotalRegisteredCubes().bronze, initialCount + 1);
    }

    function testRegisterCubeIncrementsPlatinumCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "platinum_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().platinum;
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.PLATINUM
        });
        
        cubes.registerCubes(registrations);
        assertEq(cubes.getTotalRegisteredCubes().platinum, initialCount + 1);
    }

    function testRegisterCubeIncrementsDiamondCount() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "diamond_count")
        );
        uint256 initialCount = cubes.getTotalRegisteredCubes().diamond;
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.DIAMOND
        });
        
        cubes.registerCubes(registrations);
        assertEq(cubes.getTotalRegisteredCubes().diamond, initialCount + 1);
    }

    function testRegisterCubeEmitsEvent() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "event")
        );
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });

        vm.expectEmit(true, true, true, true);
        emit CubeRegistered(coordinateHash, OneMillionCubes.CubeType.GOLD);
        cubes.registerCubes(registrations);
    }

    function testCannotRegisterCubeTwice() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "twice")
        );
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        
        cubes.registerCubes(registrations);

        OneMillionCubes.CubeRegistration[] memory registrations2 = new OneMillionCubes.CubeRegistration[](1);
        registrations2[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.SILVER
        });

        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.CubeAlreadyRegistered.selector,
                coordinateHash
            )
        );
        cubes.registerCubes(registrations2);
    }

    function testCannotRegisterInvalidCubeType() public {
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "invalid")
        );
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.NONE
        });

        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.InvalidCubeType.selector,
                OneMillionCubes.CubeType.NONE
            )
        );
        cubes.registerCubes(registrations);
    }

    function testCannotRegisterMoreThanAllowedGoldCubes() public {
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](NUM_OF_GOLD_REWARDS);
        
        for (uint i = 0; i < NUM_OF_GOLD_REWARDS; i++) {
            bytes32 coordinateHash = keccak256(
                abi.encodePacked(block.timestamp, "gold", i)
            );
            registrations[i] = OneMillionCubes.CubeRegistration({
                coordinateHash: coordinateHash,
                cubeType: OneMillionCubes.CubeType.GOLD
            });
        }
        cubes.registerCubes(registrations);

        bytes32 extraCoordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "extra_gold")
        );
        OneMillionCubes.CubeRegistration[] memory extraRegistration = new OneMillionCubes.CubeRegistration[](1);
        extraRegistration[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: extraCoordinateHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });

        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.AllCubesRegistered.selector,
                OneMillionCubes.CubeType.GOLD
            )
        );
        cubes.registerCubes(extraRegistration);
    }

    function testOnlyOwnerCanRegisterCube() public {
        vm.stopPrank();
        vm.prank(user1);
        bytes32 coordinateHash = keccak256(
            abi.encodePacked(block.timestamp, "unauthorized")
        );
        
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: coordinateHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });

        vm.expectRevert();
        cubes.registerCubes(registrations);
    }

    // Add new test for batch registration
    function testRegisterMultipleCubes() public {
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](3);
        
        bytes32 goldHash = keccak256(abi.encodePacked(block.timestamp, "gold_multi"));
        bytes32 silverHash = keccak256(abi.encodePacked(block.timestamp, "silver_multi"));
        bytes32 bronzeHash = keccak256(abi.encodePacked(block.timestamp, "bronze_multi"));
        
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: goldHash,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        registrations[1] = OneMillionCubes.CubeRegistration({
            coordinateHash: silverHash,
            cubeType: OneMillionCubes.CubeType.SILVER
        });
        registrations[2] = OneMillionCubes.CubeRegistration({
            coordinateHash: bronzeHash,
            cubeType: OneMillionCubes.CubeType.BRONZE
        });

        cubes.registerCubes(registrations);

        assertEq(uint256(cubes.getCube(goldHash)), uint256(OneMillionCubes.CubeType.GOLD));
        assertEq(uint256(cubes.getCube(silverHash)), uint256(OneMillionCubes.CubeType.SILVER));
        assertEq(uint256(cubes.getCube(bronzeHash)), uint256(OneMillionCubes.CubeType.BRONZE));
    }
}
