// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesEmergencyWithdraw is OneMillionCubesCore {
    event EmergencyWithdrawal(address indexed owner, uint256 amount);
    error WithdrawalTooEarly(uint256 currentBlock, uint256 requiredBlock);

    address payable public withdrawalRecipient;

    function setUp() public override {
        super.setUp();
        // Create a new address to receive the withdrawal
        withdrawalRecipient = payable(makeAddr("withdrawalRecipient"));
        // Transfer ownership of the cubes contract to the test contract
        vm.prank(owner);
        cubes.transferOwnership(address(this));
        // Fund the contract with some Ether for testing withdrawals
        vm.deal(address(cubes), 10 ether);
    }

    function testEmergencyWithdrawSuccess() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber + 10000);

        uint256 initialBalance = withdrawalRecipient.balance;
        uint256 contractBalance = address(cubes).balance;

        cubes.emergencyWithdraw();

        assertEq(withdrawalRecipient.balance, initialBalance + contractBalance);
        assertEq(address(cubes).balance, 0);
    }

    function testEmergencyWithdrawEmitsEvent() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber + 10000);

        vm.expectEmit(true, false, false, true);
        emit EmergencyWithdrawal(owner, address(cubes).balance);

        vm.prank(owner);
        cubes.emergencyWithdraw();
    }

    function testCannotWithdrawBeforeBlockNumber() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber - 1);

        vm.prank(owner);
        vm.expectRevert(
            abi.encodeWithSelector(
                WithdrawalTooEarly.selector,
                blockNumber - 1,
                blockNumber
            )
        );
        cubes.emergencyWithdraw();
    }

    function testCanWithdrawAtExactBlockNumber() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber);

        vm.prank(owner);
        cubes.emergencyWithdraw();

        assertEq(address(cubes).balance, 0);
    }

    function testOnlyOwnerCanWithdraw() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber + 10000);

        vm.prank(user1);
        vm.expectRevert();
        cubes.emergencyWithdraw();
    }

    function testWithdrawWhenContractBalanceIsZero() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber + 10000);

        vm.prank(owner);
        cubes.emergencyWithdraw();

        vm.prank(owner);
        cubes.emergencyWithdraw();

        assertEq(address(cubes).balance, 0);
    }

    function testWithdrawUpdatesContractBalance() public {
        (, , uint256 blockNumber, , ) = cubes.gameConfig();

        vm.roll(blockNumber + 10000);

        uint256 initialContractBalance = address(cubes).balance;

        vm.prank(owner);
        cubes.emergencyWithdraw();

        assertEq(
            address(cubes).balance,
            initialContractBalance - initialContractBalance
        );
    }

    receive() external payable {
        // Forward the received Ether to the withdrawalRecipient
        (bool success, ) = withdrawalRecipient.call{value: msg.value}("");
        require(success, "Failed to forward Ether");
    }
}
