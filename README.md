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
$ forge script script/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url http://localhost:8545 --broadcast
$ forge script script/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url http://localhost:8545 --broadcast
$ forge script script/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url http://localhost:8545 --broadcast
$ forge script script/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url http://localhost:8545 --broadcast
$ forge script script/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url http://localhost:8545 --broadcast
$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url http://localhost:8545 --broadcast
```

### Deploy (Arbitrum)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url arbitrum_mainnet --broadcast

$ forge script script/arbitrum/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url arbitrum_mainnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url arbitrum_mainnet --broadcast

$ forge script script/EmergencyWithdraw.s.sol:EmergencyWithdraw --rpc-url arbitrum_mainnet --broadcast
```

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url arbitrum_sepolia --broadcast

$ forge script script/arbitrum/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url arbitrum_sepolia --broadcast
$ forge script script/arbitrum/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url arbitrum_sepolia --broadcast
$ forge script script/arbitrum/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url arbitrum_sepolia --broadcast
$ forge script script/arbitrum/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url arbitrum_sepolia --broadcast
$ forge script script/arbitrum/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url arbitrum_sepolia --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url arbitrum_sepolia --broadcast

$ forge script script/EmergencyWithdraw.s.sol:EmergencyWithdraw --rpc-url arbitrum_sepolia --broadcast
```

Sample Contract Address: [0x92C7546CA3f38cc9dd7eB02386cffAD86090c87a](https://sepolia.arbiscan.io/address/0x92C7546CA3f38cc9dd7eB02386cffAD86090c87a)

### Deploy (Base)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url base_mainnet --broadcast

$ forge script script/base/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url base_mainnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url base_mainnet --broadcast
$ forge script script/EmergencyWithdraw.s.sol:EmergencyWithdraw --rpc-url base_mainnet --broadcast
```

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url base_sepolia --broadcast

$ forge script script/base/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url base_sepolia --broadcast
$ forge script script/base/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url base_sepolia --broadcast
$ forge script script/base/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url base_sepolia --broadcast
$ forge script script/base/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url base_sepolia --broadcast
$ forge script script/base/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url base_sepolia --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url base_sepolia --broadcast
$ forge script script/EmergencyWithdraw.s.sol:EmergencyWithdraw --rpc-url base_sepolia --broadcast
```

Sample Contract Address: [0xf1ae60D14eD26b20f05734F087132e50FA25A65d](https://sepolia.basescan.org/address/0xf1ae60D14eD26b20f05734F087132e50FA25A65d)

### Deploy (BSC)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url bsc_mainnet --broadcast

$ forge script script/bsc/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url bsc_mainnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url bsc_mainnet --broadcast
$ forge script script/EmergencyWithdraw.s.sol:EmergencyWithdraw --rpc-url bsc_mainnet --broadcast
```

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url bsc_testnet --broadcast

$ forge script script/bsc/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url bsc_testnet --broadcast
$ forge script script/bsc/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url bsc_testnet --broadcast
$ forge script script/bsc/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url bsc_testnet --broadcast
$ forge script script/bsc/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url bsc_testnet --broadcast
$ forge script script/bsc/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url bsc_testnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url bsc_testnet --broadcast
$ forge script script/EmergencyWithdraw.s.sol:EmergencyWithdraw --rpc-url bsc_testnet --broadcast
```

Sample Contract Address: [0xCEA004A2Bff2038AF7FC55Fb298fF28fd8E1B273](https://testnet.bscscan.com/address/0xCEA004A2Bff2038AF7FC55Fb298fF28fd8E1B273)

### Verify Contract (Arbitrum)

Then verify the contract:
```shell
$ forge verify-contract \
    --chain arbitrum \
    --etherscan-api-key $ARBISCAN_API_KEY \
    --watch \
    --compiler-version v0.8.20 \
    --num-of-optimizations 200 \
    --constructor-args $(cast abi-encode \
        "constructor((uint256,uint256,uint256,uint256,uint256),(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),address)" \
        "(0.0015 ether,800000,1740484800,1000000,5)" \
        "(300 ether,3,0.15 ether,500,0.03 ether,1000,0.015 ether,5000,0.003 ether,10000)" \
        "$ADMIN_SIGNER") \
    $CONTRACT_ADDRESS \
    src/OneMillionCubes.sol:OneMillionCubes
```

### Verify Contract (Base)

```shell
$ forge verify-contract \
    --chain base \
    --etherscan-api-key $BASESCAN_API_KEY \
    --watch \
    --compiler-version v0.8.20 \
    --num-of-optimizations 200 \
    --constructor-args $(cast abi-encode \
        "constructor((uint256,uint256,uint256,uint256,uint256),(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),address)" \
        "(0.0015 ether,800000,1740484800,1000000,5)" \
        "(300 ether,3,0.15 ether,500,0.03 ether,1000,0.015 ether,5000,0.003 ether,10000)" \
        "$ADMIN_SIGNER") \
    $CONTRACT_ADDRESS \
    src/OneMillionCubes.sol:OneMillionCubes
```

### Verify Contract (BSC) 

```shell
$ forge verify-contract \
    --chain bsc \
    --etherscan-api-key $BSCSCAN_API_KEY \
    --watch \
    --compiler-version v0.8.20 \
    --num-of-optimizations 200 \
    --constructor-args $(cast abi-encode \
        "constructor((uint256,uint256,uint256,uint256,uint256),(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),address)" \
        "(0.0015 ether,800000,1740484800,1000000,5)" \
        "(300 ether,3,0.15 ether,500,0.03 ether,1000,0.015 ether,5000,0.003 ether,10000)" \
        "$ADMIN_SIGNER") \
    $CONTRACT_ADDRESS \
    src/OneMillionCubes.sol:OneMillionCubes
```

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
$ cast call $CONTRACT_ADDRESS "getCoordinateSelectors((uint256,uint256)[])" "[(${X},${Y})]"
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

Get the type of a cube by its coordinate hash:
```shell
# Generate SALT_BYTES by hashing HASH_SALT with chain ID
$ CHAIN_ID=1  # For Arbitrum Sepolia
$ SALT_BYTES=$(echo -n "${HASH_SALT}_${CHAIN_ID}" | openssl dgst -sha256 -binary | xxd -p -c 32)

# Generate coordinate hash
$ COORDINATE_HASH=$(cast keccak \
  $(cast --concat-hex \
    $(cast --to-bytes32 $(cast --to-uint256 $X)) \
    $(cast --to-bytes32 $(cast --to-uint256 $Y)) \
    "0x$SALT_BYTES"))

# Query cube type
$ cast call $CONTRACT_ADDRESS "getCube(bytes32)" $COORDINATE_HASH | cast --to-dec
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