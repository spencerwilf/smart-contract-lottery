// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

/**
 * @title Smart Contract Raffle
 * @author Spencer Wilfahrt
 * @notice This contract creates a provably random onchain lottery
 */

contract Raffle {

    error Raffle__NotEnoughEthSent();

    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    uint256 private immutable i_entranceFee;
    // @dev Duration of lottery in seconds
    uint256 private immutable i_interval;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;

    address payable[] private s_players;
    uint256 private s_lastTimeStamp;
    

    /** Events **/
    event EnteredRaffle(address indexed player);
    

    constructor(uint256 entranceFee, uint256 interval, address vrfCoordinator, bytes32 gasLane, uint64 subscriptionId, uint32 callbackGasLimit) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        i_gasLane = gasLane;
        s_lastTimeStamp = block.timestamp;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
    }

    function enterRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
       if (block.timestamp - s_lastTimeStamp <= i_interval) {
        revert();
       }
       uint256 requestId = i_vrfCoordinator.requestRandomWords(
        i_gasLane,
        i_subscriptionId,
        REQUEST_CONFIRMATIONS,
        i_callbackGasLimit,
        NUM_WORDS

       );
    }

    /** GETTER FUNCTIONS **/

    function getEntranceFee() external view returns(uint256) {
        return i_entranceFee;
    }
}