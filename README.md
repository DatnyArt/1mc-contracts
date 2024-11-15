## 1 Milion Cubes

### Install dependencies using Soldeer

[Soldeer](https://soldeer.xyz/) is a Solidity Package Manager

After you `clone` the repository, go to the project catalog and type:

```shell
$ soldeer install
```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### ABI

```shell
$ forge inspect OneMillionCubes abi > abi/OneMilionCubes.json
```

### Deploy (Anvil)

```shell
$ anvil
```

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url http://localhost:8545 --broadcast
$ forge script script/RegisterCubes.s.sol:RegisterCubes --rpc-url http://localhost:8545 --broadcast
$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url http://localhost:8545 --broadcast
```

### Deploy (Arbitrum Sepolia)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url arbitrum_sepolia --broadcast
$ forge script script/RegisterCubes.s.sol:RegisterCubes --rpc-url arbitrum_sepolia --broadcast
$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url arbitrum_sepolia --broadcast
```

Sample Contract Address: [0xdd06724f208b5a561a001ba23f989b874f1c204a](https://sepolia.arbiscan.io/address/0xdd06724f208b5a561a001ba23f989b874f1c204a)

### Verify Contract (Arbitrum Sepolia)

First, ensure you have your Arbiscan API key in your environment:
```shell
$ export ARBISCAN_API_KEY=your_api_key_here
```

Then verify the contract:
```shell
$ forge verify-contract \
    --chain arbitrum-sepolia \
    --etherscan-api-key $ARBISCAN_API_KEY \
    --watch \
    --compiler-version v0.8.20 \
    --num-of-optimizations 200 \
    --constructor-args 0x0000000000000000000000000000000000000000000000000005af3107a4000000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000005dd11c200000000000000000000000000000000000000000000000000000000000003e80000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000016345785d8a0000000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000b1a2bc2ec50000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000058d15e176280000000000000000000000000000000000000000000000000000000000000000014000000000000000000000000000000000000000000000000002386f26fc1000000000000000000000000000000000000000000000000000000000000000000320000000000000000000000000000000000000000000000000011c37937e080000000000000000000000000000000000000000000000000000000000000000064000000000000000000000000c451fb3989e422d6b5c49f5c6eca965a2c821297 \
    0xdd06724f208b5a561a001ba23f989b874f1c204a \
    src/OneMillionCubes.sol:OneMillionCubes
```

The constructor arguments decoded from the deployment transaction:

GameConfig:
- fee: 1600000000000000 (0.0016 ether)
- minDiscElemNumb: 80
- blockNumber: 98374105
- totalElemNumb: 1000
- maxSelectionsPerTx: 5

RewardParameters:
- singleGoldReward: 100000000000000000 (0.1 ether)
- numOfGoldRewards: 3
- singleSilverReward: 50000000000000000 (0.05 ether)
- numOfSilverRewards: 10
- singleBronzeReward: 25000000000000000 (0.025 ether)
- numOfBronzeRewards: 20
- singlePlatinumReward: 10000000000000000 (0.01 ether)
- numOfPlatinumRewards: 50
- singleDiamondReward: 5000000000000000 (0.005 ether)
- numOfDiamondRewards: 100

adminSigner: 0xc451fb3989e422d6b5c49f5c6eca965a2c821297

### Deploy (Ethereum Sepolia)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url ethereum_sepolia --broadcast
$ forge script script/RegisterCubes.s.sol:RegisterCubes --rpc-url ethereum_sepolia --broadcast
$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url ethereum_sepolia --broadcast
```

Sample Contract Address: [0xCe80efd4A439c1ED151AfCB84506B6748B4882aC](https://sepolia.etherscan.io/address/0xCe80efd4A439c1ED151AfCB84506B6748B4882aC)

### Interact with Contract (Anvil)

First, load the environment variables:
```shell
$ source .env
```

Check if contract is initialized:
```shell
$ cast call $CONTRACT_ADDRESS "isInitialized()" | cast --to-dec
```

Select Cube
```shell
cast send $CONTRACT_ADDRESS "selectCube((uint256,uint256)[],address)" "[(${X},${Y})]" "${REFERRER_ADDRESS}" --value $CUBE_FEE --private-key $PRIVATE_KEY
```

Check if coordinate is already selected:
```shell
$ cast call $CONTRACT_ADDRESS "getCoordinateSelector(uint256,uint256)" $X $Y | sed 's/0x000000000000000000000000/0x/' | cast --to-checksum-address
```

#### View Functions
Get total number of registered cubes by type:
```shell
$ # Get the result and split it into separate values
RESULT=$(cast call $CONTRACT_ADDRESS "getTotalRegisteredCubes()")

# Extract each 64-character chunk (32 bytes) and convert to decimal
GOLD="0x${RESULT:2:64}"
SILVER="0x${RESULT:66:64}"
BRONZE="0x${RESULT:130:64}"
PLATINUM="0x${RESULT:194:64}"
DIAMOND="0x${RESULT:258:64}"

# Format and display
echo "Cube Counts:"
echo "Gold:     $(cast --to-dec $GOLD)"
echo "Silver:   $(cast --to-dec $SILVER)"
echo "Bronze:   $(cast --to-dec $BRONZE)"
echo "Platinum: $(cast --to-dec $PLATINUM)"
echo "Diamond:  $(cast --to-dec $DIAMOND)"
```

Get all selections made by a specific user:
```shell
$ cast call $CONTRACT_ADDRESS "getUserSelections(address)" $(cast wallet address $PRIVATE_KEY)
```

Get the address of who selected a specific coordinate:
```shell
$ cast call $CONTRACT_ADDRESS "getCoordinateSelector(uint256,uint256)" $X $Y
```

Get the type of a cube by its coordinate hash:
```shell
$ cast call $CONTRACT_ADDRESS "getCube(bytes32)" <COORDINATE_HASH>
```

Get referral statistics for an address:
```shell
$ cast call $CONTRACT_ADDRESS "getReferralCount(address)" $REFERRER_ADDRESS
```

Check if a cube exists by its coordinate hash:
```shell
$ SALT_BYTES=$(echo -n $HASH_SALT | openssl dgst -sha256 -binary | xxd -p -c 32)
$ COORDINATE_HASH=$(cast keccak \
  $(cast --concat-hex \
    $(cast --to-bytes32 $(cast --to-uint256 $X)) \
    $(cast --to-bytes32 $(cast --to-uint256 $Y)) \
    "0x$SALT_BYTES"))
$ cast call $CONTRACT_ADDRESS "getCube(bytes32)" $COORDINATE_HASH | cast --to-dec
```