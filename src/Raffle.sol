// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

/**
 * @title Smart Contract Raffle
 * @author Spencer Wilfahrt
 * @notice This contract creates a provably random onchain lottery
 */

contract Raffle {

    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    /** Events **/
    event EnteredRaffle(address indexed player);
    

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {

    }

    /** GETTER FUNCTIONS **/

    function getEntranceFee() external view returns(uint256) {
        return i_entranceFee;
    }
}