
## Description

This repository contains a decentralized, provably random smart contract lottery implemented using Solidity, Foundry, and Chainlink. Participants can enter the lottery by interacting with the smart contract, and the winner is selected using a provably random mechanism provided by Chainlink VRF (Verifiable Random Function).

## Features

- **Decentralized**: Operates on Ethereum blockchain ensuring transparency and trustlessness.
- **Provably Random**: Utilizes Chainlink VRF for fair and transparent winner selection.
- **Built with Solidity, Foundry, and Chainlink**: Leveraging reputable and robust technologies in the blockchain space.

## Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/spencerwilf/smart-contract-lottery.git
Navigate to the project directory:

bash
Copy code
cd smart-contract-lottery
Install dependencies:

bash
Copy code
npm install
Usage
Provide instructions on how to deploy and interact with the smart contract lottery, detailing any specific steps or scripts.

Raffle Contract Control Flow
Initialization (Constructor)

The Raffle contract is initialized with a set entrance fee, interval, VRF Coordinator address, gas lane, subscription ID, and callback gas limit.
The initial raffle state is set to OPEN.
Entering the Raffle

Players can enter the raffle by calling the enterRaffle function and sending the specified entrance fee.
Players are added to the s_players array, and an EnteredRaffle event is emitted.
Upkeep Check

The checkUpkeep function checks if the time for the next raffle draw has arrived, the raffle is open, there is a balance to distribute, and there are players in the raffle.
This function is meant to be used with an external system, like a Chainlink Keeper, to automate the upkeep process.
Performing Upkeep

The performUpkeep function is called externally, likely by a Chainlink Keeper, to trigger the process of picking a winner.
The raffle state is set to CALCULATING, and a random number request is made to the Chainlink VRF Coordinator.
Fulfilling Random Number Request

The fulfillRandomWords function is called by the VRF Coordinator with the random number.
A winner is selected based on the random number, the raffle state is set back to OPEN, and the contract balance is transferred to the winner.
The s_players array is reset, and the s_lastTimeStamp is updated to the current block timestamp.
Querying Information

Various getter functions are available to query information about the raffle, such as the entrance fee, raffle state, and player addresses.
Contributing
We welcome contributions! Please see CONTRIBUTING.md for details on how to contribute.

License
This project is licensed under the MIT License.

Contact
GitHub: @spencerwilf
go
Copy code

You can copy and paste the entire block above into your `README.md` file in your GitHub repository.
