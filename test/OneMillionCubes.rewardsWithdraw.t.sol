// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";
import "@openzeppelin-contracts-5.0.2/utils/cryptography/ECDSA.sol";
import "@openzeppelin-contracts-5.0.2/utils/cryptography/MessageHashUtils.sol";

contract OneMillionCubesRewardsWithdraw is OneMillionCubesCore {
    event RewardWithdrawal(
        address indexed user,
        uint256 amount,
        bytes32 cubeHash
    );

    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;

    uint256 constant X = 100;
    uint256 constant Y = 200;
    bytes32 constant CUBE_HASH = keccak256(abi.encodePacked(X, Y));
    uint256 constant adminSignerPrivateKey = 0xA11CE;

    function setUp() public override {
        super.setUp();

        // Set the adminSigner using the private key
        adminSigner = vm.addr(adminSignerPrivateKey);

        // Recreate the cubes contract with the correct adminSigner
        OneMillionCubes.GameConfig memory gameConfig = OneMillionCubes.GameConfig({
            fee: FEE,
            minDiscElemNumb: MIN_DISC_ELEM_NUMB,
            blockTimestamp: block.timestamp + 1000,
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

        cubes = new OneMillionCubes(gameConfig, rewardParams, adminSigner);

        // Initialize the contract
        vm.prank(owner);
        cubes.initialize();

        // Fund the contract with rewards
        vm.deal(address(cubes), 1000 ether);

        // Register cubes
        vm.prank(owner);
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: CUBE_HASH,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        cubes.registerCubes(registrations);

        // Simulate minimum selections
        for (uint i = 0; i < MIN_DISC_ELEM_NUMB; i++) {
            address selector = makeAddr(string(abi.encodePacked("user", i)));
            vm.deal(selector, FEE);
            vm.prank(selector);
            OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
            selections[0] = OneMillionCubes.Selection({x: i, y: i});
            cubes.selectCube{value: FEE}(selections, ref1);
        }

        // Select the cube for user1
        vm.deal(user1, FEE);
        vm.prank(user1);
        OneMillionCubes.Selection[] memory userSelections = new OneMillionCubes.Selection[](1);
        userSelections[0] = OneMillionCubes.Selection({x: X, y: Y});
        cubes.selectCube{value: FEE}(userSelections, ref2);
    }

    function testRewardWithdrawSuccess() public {
        bytes32 messageHash = keccak256(
            abi.encodePacked(X, Y, user1, CUBE_HASH)
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            adminSignerPrivateKey,
            messageHash.toEthSignedMessageHash()
        );
        bytes memory signature = abi.encodePacked(r, s, v);

        uint256 initialBalance = user1.balance;

        vm.prank(user1);
        cubes.rewardWithdraw(X, Y, CUBE_HASH, signature);

        assertEq(user1.balance, initialBalance + SINGLE_GOLD_REWARD);
    }

    function testRewardWithdrawEmitsEvent() public {
        bytes32 messageHash = keccak256(
            abi.encodePacked(X, Y, user1, CUBE_HASH)
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            adminSignerPrivateKey,
            messageHash.toEthSignedMessageHash()
        );
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.expectEmit(true, false, false, true);
        emit RewardWithdrawal(user1, SINGLE_GOLD_REWARD, CUBE_HASH);

        vm.prank(user1);
        cubes.rewardWithdraw(X, Y, CUBE_HASH, signature);
    }

    function testCannotWithdrawWithLessThanMinimumSelections() public {
        // Reset the contract state
        OneMillionCubes.GameConfig memory gameConfig = OneMillionCubes.GameConfig({
            fee: FEE,
            minDiscElemNumb: MIN_DISC_ELEM_NUMB,
            blockTimestamp: block.timestamp + 1000,
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

        cubes = new OneMillionCubes(gameConfig, rewardParams, adminSigner);

        // Fund the contract
        vm.deal(address(cubes), 10 ether);

        // Register the cube
        vm.prank(owner);
        OneMillionCubes.CubeRegistration[] memory registrations = new OneMillionCubes.CubeRegistration[](1);
        registrations[0] = OneMillionCubes.CubeRegistration({
            coordinateHash: CUBE_HASH,
            cubeType: OneMillionCubes.CubeType.GOLD
        });
        cubes.registerCubes(registrations);

        // Initialize the contract
        vm.prank(owner);
        cubes.initialize();

        // Make MIN_DISC_ELEM_NUMB - 2 selections (not including user1's selection)
        for (uint i = 0; i < MIN_DISC_ELEM_NUMB - 2; i++) {
            address selector = makeAddr(string(abi.encodePacked("newuser", i)));
            vm.deal(selector, FEE);
            vm.prank(selector);
            OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
            selections[0] = OneMillionCubes.Selection({x: i, y: i});
            cubes.selectCube{value: FEE}(selections, ref1);
        }

        // Select the cube for user1
        vm.deal(user1, FEE);
        vm.prank(user1);
        OneMillionCubes.Selection[] memory userSelections = new OneMillionCubes.Selection[](1);
        userSelections[0] = OneMillionCubes.Selection({x: X, y: Y});
        cubes.selectCube{value: FEE}(userSelections, ref2);

        // Prepare the signature
        bytes32 messageHash = keccak256(
            abi.encodePacked(X, Y, user1, CUBE_HASH)
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            adminSignerPrivateKey,
            messageHash.toEthSignedMessageHash()
        );
        bytes memory signature = abi.encodePacked(r, s, v);

        // Attempt to withdraw and expect it to revert
        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(
                OneMillionCubes.InsufficientSelections.selector,
                MIN_DISC_ELEM_NUMB - 1,
                MIN_DISC_ELEM_NUMB
            )
        );
        cubes.rewardWithdraw(X, Y, CUBE_HASH, signature);
    }

    function testCannotWithdrawWithInvalidSignature() public {
        bytes32 messageHash = keccak256(
            abi.encodePacked(X, Y, user1, CUBE_HASH)
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            uint256(1),
            messageHash.toEthSignedMessageHash()
        );
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.prank(user1);
        vm.expectRevert(OneMillionCubes.InvalidSignature.selector);
        cubes.rewardWithdraw(X, Y, CUBE_HASH, signature);
    }

    function testCannotWithdrawForUnselectedCube() public {
        bytes32 messageHash = keccak256(
            abi.encodePacked(X + 1, Y + 1, user1, CUBE_HASH)
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            adminSignerPrivateKey,
            messageHash.toEthSignedMessageHash()
        );
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.prank(user1);
        vm.expectRevert(OneMillionCubes.InvalidUser.selector);
        cubes.rewardWithdraw(X + 1, Y + 1, CUBE_HASH, signature);
    }

    function testCannotWithdrawRewardTwice() public {
        bytes32 messageHash = keccak256(
            abi.encodePacked(X, Y, user1, CUBE_HASH)
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            adminSignerPrivateKey,
            messageHash.toEthSignedMessageHash()
        );
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.prank(user1);
        cubes.rewardWithdraw(X, Y, CUBE_HASH, signature);

        vm.prank(user1);
        vm.expectRevert(OneMillionCubes.RewardAlreadyClaimed.selector);
        cubes.rewardWithdraw(X, Y, CUBE_HASH, signature);
    }

    // Add new test for uninitialized contract
    function testCannotSelectCubeWhenNotInitialized() public {
        // Deploy a new contract without initializing it
        OneMillionCubes.GameConfig memory gameConfig = OneMillionCubes.GameConfig({
            fee: FEE,
            minDiscElemNumb: MIN_DISC_ELEM_NUMB,
            blockTimestamp: block.timestamp + 1000,
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

        // Try to select cube without initializing
        OneMillionCubes.Selection[] memory selections = new OneMillionCubes.Selection[](1);
        selections[0] = OneMillionCubes.Selection({x: X, y: Y});

        vm.prank(user1);
        vm.expectRevert();
        uninitializedCubes.selectCube{value: FEE}(selections, ref1);
    }
}
