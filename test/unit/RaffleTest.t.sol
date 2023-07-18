// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {Raffle} from "../../src/Raffle.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract RaffleTest is Test {
    Raffle raffle;
    HelperConfig helperConfig;

        uint256 entranceFee; 
        uint256 interval; 
        address vrfCoordinator; 
        bytes32 gasLane; 
        uint64 subscriptionId; 
        uint32 callbackGasLimit;

    address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle, helperConfig) = deployer.run();
        (entranceFee, 
         interval, 
         vrfCoordinator, 
         gasLane, 
         subscriptionId, 
         callbackGasLimit) = helperConfig.activeNetworkConfig();

    }

    function testRaffleInitializes() public view {
        assert(raffle.getRaffleState() == Raffle.RaffleState.OPEN);
    }
}