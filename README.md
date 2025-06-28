# kiichain

#  Deployment Script

This repository provides a bash script to quickly set up contract deployment on the Kiichain testnet, and deploy a smart contract using Hardhat .

## Requirements

- **Node.js** (>= 14.x)
- **npm** (>= 6.x)
- **Kiichain testnet private key** (0x... format)

## What the Script Does

The script performs the following tasks:

1. **Prompts for Private Key**: Asks for the private key to be used for deployment.
2. **Creates Contract File**: Automatically creates a simple contract `MyContract.sol` under the `contracts/` directory.
3. **Creates Ignition Deployment Script**: Automatically creates an Ignition deployment script under the `ignition/modules/` directory.
4. **Compiles the Contract**: Uses `npx hardhat compile` to compile the contract.5
5. **Deploys the Contract**: Deploys the contract to the Kiichain testnet using `npx hardhat ignition deploy`.

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/codewithalexsz/kiichain && cd kiichain && chmod +x deploy.sh && ./deploy.sh
   ```
![image](https://github.com/user-attachments/assets/9d726bc8-8284-4ea6-92b0-1691793aaba5)

**select Create a Javascript Project ( enter key ) >> Project root ( Enter key ) >> git ignore ( y key)**


Compile >> Deploy ( y )

done
