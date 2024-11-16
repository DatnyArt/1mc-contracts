// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesSelectCube is OneMillionCubesCore {
    event CubeSelected(address indexed user, uint256 x, uint256 y, uint256 fee);
    event CubeSelectedWithReferral(
        address indexed user,
        uint256 x,
        uint256 y,
        uint256 fee,
        address indexed referrer
    );

    function setUp() public override {
        super.setUp();
        // Initialize the contract
        vm.prank(owner);
        cubes.initialize();
    }

    // Add new test for uninitialized contract
    function testCannotSelectCubeWhenNotInitialized() public {
        // Deploy a new contract without initializing it
        OneMillionCubes.GameConfig memory gameConfig = OneMillionCubes.GameConfig({
            fee: FEE,
            minDiscElemNumb: MIN_DISC_ELEM_NUMB,
            blockNumber: block.number + 1000,
            totalElemNumb: TOTAL_ELEM_NUMB,
            maxSelectionsPerTx: MAX_SELECTIONS_PER_TX
        });

        OneMillionCubes.RewardParameters memory rewardParams = OneMillionCubes.RewardParameters({
            singleGoldReward: SINGLE_GOLD_REWARD,
            numOfGoldRewards: NUM_OF_GOLD_REWARDS,
            singleSilverReward: SINGLE_SILVER_REWARD,
            numOfSilverRewards: NUM_OF_SILVER_REWARDS,
            singleBronzeReward: SINGLE_BRONZE_REWARD,
            numOfBronzeRewards: NUM_OF_BRONZE_REWARDS,
            singlePlatinumReward: SINGLE_PLATINUM_REWARD,
            numOfPlatinumRewards: NUM_OF_PLATINUM_REWARDS,
            singleDiamondReward: SINGLE_DIAMOND_REWARD,
            numOfDiamondRewards: NUM_OF_DIAMOND_REWARDS
        });

        OneMillionCubes uninitializedCubes = new OneMillionCubes(
            gameConfig,
            rewardParams,
            adminSigner
        );

        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 10, y: 20});

        vm.prank(user1);
        vm.expectRevert(OneMillionCubes.ContractNotInitialized.selector);
        uninitializedCubes.selectCube{value: FEE}(selections, ref1);
    }

    // Rest of the existing tests remain the same as they use the initialized contract from setUp
    function testSelectCubeSuccess() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 10, y: 20});

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, ref1);

        OneMillionCubes.Selection[] memory userSelections = cubes.getUserSelections(user1);
        assertEq(userSelections.length, 1);
        assertEq(userSelections[0].x, 10);
        assertEq(userSelections[0].y, 20);
    }

    function testSelectCubeEmitsEvent() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 30, y: 40});

        vm.expectEmit(true, false, false, true);
        emit CubeSelected(user1, 30, 40, FEE);

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, address0);
    }

    function testSelectCubeEmitsEventWhenReferral() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 30, y: 40});

        vm.expectEmit(true, false, false, true);
        emit CubeSelectedWithReferral(user1, 30, 40, FEE, ref1);

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, ref1);
    }

    function testSelectCubeIncreasesTotalSelections() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 50, y: 60});

        uint256 initialSelections = cubes.totalSelections();

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, ref1);

        assertEq(cubes.totalSelections(), initialSelections + 1);
    }

    function testSelectCubeUpdatesCoordinateSelections() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 70, y: 80});

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, ref1);

        // Create selection array for query
        OneMillionCubes.Selection[] memory querySelections = new OneMillionCubes.Selection[](1);
        querySelections[0] = OneMillionCubes.Selection({x: 70, y: 80});
        
        address[] memory selectors = cubes.getCoordinateSelectors(querySelections);
        assertEq(selectors.length, 1);
        assertEq(selectors[0], user1);
    }

    function testGetMultipleCoordinateSelectors() public {
        OneMillionCubes.Selection[] memory selections1 = new OneMillionCubes.Selection[](1);
        selections1[0] = OneMillionCubes.Selection({x: 90, y: 100});
        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections1, ref1);

        OneMillionCubes.Selection[] memory selections2 = new OneMillionCubes.Selection[](1);
        selections2[0] = OneMillionCubes.Selection({x: 110, y: 120});
        vm.prank(user2);
        cubes.selectCube{value: FEE}(selections2, ref1);

        OneMillionCubes.Selection[] memory querySelections = new OneMillionCubes.Selection[](2);
        querySelections[0] = OneMillionCubes.Selection({x: 90, y: 100});
        querySelections[1] = OneMillionCubes.Selection({x: 110, y: 120});

        address[] memory selectors = cubes.getCoordinateSelectors(querySelections);
        
        assertEq(selectors.length, 2);
        assertEq(selectors[0], user1);
        assertEq(selectors[1], user2);
    }

    function testGetEmptyCoordinateSelectors() public view {
        OneMillionCubes.Selection[] memory querySelections = new OneMillionCubes.Selection[](0);
        address[] memory selectors = cubes.getCoordinateSelectors(querySelections);
        assertEq(selectors.length, 0);
    }

    function testGetUnselectedCoordinateSelectors() public view {
        OneMillionCubes.Selection[] memory querySelections = new OneMillionCubes.Selection[](1);
        querySelections[0] = OneMillionCubes.Selection({x: 130, y: 140});
        
        address[] memory selectors = cubes.getCoordinateSelectors(querySelections);
        
        assertEq(selectors.length, 1);
        assertEq(selectors[0], address(0));
    }

    function testCannotSelectCubeWithInsufficientFee() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 90, y: 100});

        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.InsufficientFee.selector,
                FEE - 1,
                FEE
            )
        );
        cubes.selectCube{value: FEE - 1}(selections, ref1);
    }

    function testCannotSelectAlreadySelectedCoordinate() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 110, y: 120});

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, ref1);

        vm.prank(user2);
        vm.expectRevert(OneMillionCubes.CoordinateAlreadySelected.selector);
        cubes.selectCube{value: FEE}(selections, ref1);
    }

    function testSelectMultipleCubesByOneUser() public {
        vm.startPrank(user1);

        // Create three separate selections
        for (uint i = 0; i < 3; i++) {
            OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
            selections[0] = OneMillionCubes.Selection({
                x: 130 + (i * 20),
                y: 140 + (i * 20)
            });
            cubes.selectCube{value: FEE}(selections, ref1);
        }

        OneMillionCubes.Selection[] memory userSelections = cubes.getUserSelections(user1);
        assertEq(userSelections.length, 3);
        assertEq(userSelections[0].x, 130);
        assertEq(userSelections[0].y, 140);
        assertEq(userSelections[1].x, 150);
        assertEq(userSelections[1].y, 160);
        assertEq(userSelections[2].x, 170);
        assertEq(userSelections[2].y, 180);

        vm.stopPrank();
    }

    function testSelectMultipleCubesInSingleTransaction() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](3);
        selections[0] = OneMillionCubes.Selection({x: 130, y: 140});
        selections[1] = OneMillionCubes.Selection({x: 150, y: 160});
        selections[2] = OneMillionCubes.Selection({x: 170, y: 180});

        vm.prank(user1);
        cubes.selectCube{value: FEE * 3}(selections, ref1);

        OneMillionCubes.Selection[] memory userSelections = cubes.getUserSelections(user1);
        assertEq(userSelections.length, 3);
        assertEq(userSelections[0].x, 130);
        assertEq(userSelections[0].y, 140);
        assertEq(userSelections[1].x, 150);
        assertEq(userSelections[1].y, 160);
        assertEq(userSelections[2].x, 170);
        assertEq(userSelections[2].y, 180);
    }

    function testCannotSelectMoreThanFiveCubes() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](6);
        for (uint i = 0; i < 6; i++) {
            selections[i] = OneMillionCubes.Selection({
                x: 100 + i,
                y: 200 + i
            });
        }

        vm.prank(user1);
        vm.expectRevert(abi.encodeWithSelector(OneMillionCubes.TooManySelections.selector, 6));
        cubes.selectCube{value: FEE * 6}(selections, ref1);
    }

    function testSelectCubeUpdatesContractBalance() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: 210, y: 220});

        uint256 initialBalance = address(cubes).balance;

        vm.prank(user1);
        cubes.selectCube{value: FEE}(selections, ref1);

        assertEq(address(cubes).balance, initialBalance + FEE);
    }

    function testSelectMultipleCubesUpdatesContractBalance() public {
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](3);
        selections[0] = OneMillionCubes.Selection({x: 230, y: 240});
        selections[1] = OneMillionCubes.Selection({x: 250, y: 260});
        selections[2] = OneMillionCubes.Selection({x: 270, y: 280});

        uint256 initialBalance = address(cubes).balance;

        vm.prank(user1);
        cubes.selectCube{value: FEE * 3}(selections, ref1);

        assertEq(address(cubes).balance, initialBalance + (FEE * 3));
    }

    function testReferralCountingSystem() public {
        // First user selects 5 cubes with ref1 as referrer
        OneMillionCubes.Selection[] memory selectionsUser1 = new OneMillionCubes.Selection[](5);
        for (uint i = 0; i < 5; i++) {
            selectionsUser1[i] = OneMillionCubes.Selection({
                x: 100 + i,
                y: 200 + i
            });
        }
        
        vm.prank(user1);
        cubes.selectCube{value: FEE * 5}(selectionsUser1, ref1);

        // Second user selects 5 different cubes with the same referrer
        OneMillionCubes.Selection[] memory selectionsUser2 = new OneMillionCubes.Selection[](5);
        for (uint i = 0; i < 5; i++) {
            selectionsUser2[i] = OneMillionCubes.Selection({
                x: 300 + i,
                y: 400 + i
            });
        }

        vm.prank(user2);
        cubes.selectCube{value: FEE * 5}(selectionsUser2, ref1);

        // Check referral statistics
        (uint256 referralCount, uint256 cubesSelectedWithReferral) = cubes.getReferralCount(ref1);
        
        // Verify that ref1 was used as referrer 2 times
        assertEq(referralCount, 2, "Referral count should be 2");
        // Verify that total number of cubes selected with ref1 as referrer is 10
        assertEq(cubesSelectedWithReferral, 10, "Total cubes selected with referral should be 10");
    }
}
