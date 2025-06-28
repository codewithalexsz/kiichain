#!/bin/bash

# Prompt user for private key
read -p "Enter your private key (0x...): " PRIVATE_KEY

# Validate the private key format
if [[ ! "$PRIVATE_KEY" =~ ^0x[a-fA-F0-9]{64}$ ]]; then
  echo "❌ Invalid private key format."
  exit 1
fi

# Directories to clean if project exists
PROJECT_FILES=("hardhat.config.js" "test"  "package-lock.json" "node_modules" "contracts" "scripts" "ignition")

# Function to delete existing project files
delete_existing_project() {
  echo "⚠️  Existing Hardhat project found. Deleting old project..."
  
  # Delete project files (ignoring the setup script itself)
  for file in "${PROJECT_FILES[@]}"; do
    if [ -e "$file" ]; then
      echo "Deleting $file ..."
      rm -rf "$file"
    fi
  done

  echo "✅ Old Hardhat project deleted."
}

# Check if the project files/folders exist
existing_project=false
for file in "${PROJECT_FILES[@]}"; do
  if [ -e "$file" ]; then
    existing_project=true
    break
  fi
done

# If project exists, delete old files/folders
if $existing_project; then
  delete_existing_project
fi

# Install Hardhat and dependencies
echo "🔧 Installing Hardhat and dependencies..."
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox hardhat-ignition

# Initialize a new Hardhat project
echo "📁 Initializing Hardhat project..."
npx hardhat init --force

# Create Hardhat config (JavaScript version)
echo "✏️ Writing Hardhat config..."
cat <<EOL > hardhat.config.js
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.28", 
  networks: {
    kiichain: {
      url: "https://json-rpc.uno.sentry.testnet.v3.kiivalidator.com/",
      chainId: 1336,
      accounts: ["$PRIVATE_KEY"]
    },
  },
};
EOL

echo "✅ Hardhat configuration completed."

echo "✅ Contract file created."


echo "✅ Ignition deployment script created."

# Compile the contract
echo "🔨 Compiling the contract..."
npx hardhat compile

# Deploy the contract using Ignition
echo "🚀 Deploying contract..."
npx hardhat ignition deploy ignition/modules/Lock.js --network kiichain

echo "✅ Deployment successful!"
