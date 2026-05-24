# Decentralized Fundraiser DApp

A blockchain-based fundraising application built with **Solidity** and a **HTML/CSS/JavaScript** frontend.  
The DApp allows users to donate ETH to a campaign, tracks contributions on-chain, and supports refunds or withdrawals depending on the campaign outcome.

## Features

- Donate ETH to the fundraiser
- Track total funds raised on-chain
- Store individual donor contributions
- Enforce a funding deadline
- Allow refunds if the goal is not reached
- Allow owner-only withdrawal if the goal is reached
- Emit events for important contract actions
- Simple frontend for interacting with the smart contract

## Tech Stack

- **Solidity** for the smart contract
- **HTML/CSS/JavaScript** for the frontend
- **Remix IDE** for development and testing
- **MetaMask** for wallet interaction
- **Sepolia Ethereum testnet** for deployment/testing

## How It Works

1. A campaign is created with a goal amount and deadline.
2. Users send ETH to the contract using the donate function.
3. The contract records each donor's contribution.
4. After the deadline:
   - If the goal is reached, the owner can withdraw the funds.
   - If the goal is not reached, donors can claim refunds.

## Smart Contract Overview

The contract includes:

- `donate()` — accepts donations
- `withdraw()` — allows the owner to withdraw funds after success
- `refund()` — allows donors to reclaim funds if the goal fails
- `donations` mapping — tracks each donor's contribution
- `totalRaised` — total amount raised
- `deadline` — fundraiser ending time
- `withdrawn` — prevents double withdrawal

## Security Considerations

- Uses owner-only access for withdrawal
- Uses reentrancy protection
- Follows checks-effects-interactions style for ETH transfers
- Prevents multiple withdrawals

## Getting Started

### Prerequisites
- MetaMask installed
- Remix IDE opened in browser
- An Ethereum test network or Remix VM

### Deployment
1. Open the Solidity file in Remix IDE.
2. Compile the contract.
3. Deploy it using Remix VM or MetaMask.
4. Connect the frontend to the deployed contract address by changing the contract address field in the .html file.
5. Open the .html file through an open server.
6. Interact with the DApp by donating, checking status, or withdrawing/refunding based on campaign conditions.

## Author
Sanu Singh
