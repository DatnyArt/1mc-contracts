// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./OneMillionCubesCore.t.sol";

contract OneMillionCubesEmergencyWithdraw is OneMillionCubesCore {
    event EmergencyWithdrawal(address indexed owner, uint256 amount);
    error WithdrawalTooEarly(uint256 currentTimestamp, uint256 requiredTimestamp);
    error InsufficientContractBalance(uint256 requested, uint256 available);

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
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        uint256 initialBalance = withdrawalRecipient.balance;
        uint256 withdrawAmount = 5 ether;

        cubes.emergencyWithdraw(withdrawAmount);

        assertEq(withdrawalRecipient.balance, initialBalance + withdrawAmount);
        assertEq(address(cubes).balance, 5 ether);
    }

    function testEmergencyWithdrawFullBalance() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        uint256 initialBalance = withdrawalRecipient.balance;
        uint256 contractBalance = address(cubes).balance;

        cubes.emergencyWithdraw(contractBalance);

        assertEq(withdrawalRecipient.balance, initialBalance + contractBalance);
        assertEq(address(cubes).balance, 0);
    }

    function testEmergencyWithdrawEmitsEvent() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        uint256 withdrawAmount = 1 ether;

        vm.expectEmit(true, false, false, true);
        emit EmergencyWithdrawal(owner, withdrawAmount);

        vm.prank(owner);
        cubes.emergencyWithdraw(withdrawAmount);
    }

    function testCannotWithdrawBeforeTimestamp() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp - 1);

        vm.prank(owner);
        vm.expectRevert(
            abi.encodeWithSelector(
                WithdrawalTooEarly.selector,
                timestamp - 1,
                timestamp
            )
        );
        cubes.emergencyWithdraw(1 ether);
    }

    function testCanWithdrawAtExactTimestamp() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp);

        uint256 withdrawAmount = 1 ether;
        vm.prank(owner);
        cubes.emergencyWithdraw(withdrawAmount);

        assertEq(address(cubes).balance, 9 ether);
    }

    function testOnlyOwnerCanWithdraw() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        vm.prank(user1);
        vm.expectRevert();
        cubes.emergencyWithdraw(1 ether);
    }

    function testCannotWithdrawMoreThanContractBalance() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        uint256 contractBalance = address(cubes).balance;
        uint256 excessAmount = contractBalance + 1 ether;

        vm.expectRevert(
            abi.encodeWithSelector(
                InsufficientContractBalance.selector,
                excessAmount,
                contractBalance
            )
        );
        cubes.emergencyWithdraw(excessAmount);
    }

    function testWithdrawUpdatesContractBalance() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        uint256 initialContractBalance = address(cubes).balance;
        uint256 withdrawAmount = 2 ether;

        vm.prank(owner);
        cubes.emergencyWithdraw(withdrawAmount);

        assertEq(
            address(cubes).balance,
            initialContractBalance - withdrawAmount
        );
    }

    function testMultiplePartialWithdrawals() public {
        (, , uint256 timestamp, , ) = cubes.gameConfig();
        vm.warp(timestamp + 10000);

        uint256 firstWithdrawal = 3 ether;
        uint256 secondWithdrawal = 2 ether;

        vm.prank(owner);
        cubes.emergencyWithdraw(firstWithdrawal);
        assertEq(address(cubes).balance, 7 ether);

        vm.prank(owner);
        cubes.emergencyWithdraw(secondWithdrawal);
        assertEq(address(cubes).balance, 5 ether);
    }

    receive() external payable {
        // Forward the received Ether to the withdrawalRecipient
        (bool success, ) = withdrawalRecipient.call{value: msg.value}("");
        require(success, "Failed to forward Ether");
    }
}
