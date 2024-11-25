## 1 Million Cubes

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

### Deploy (Arbitrum)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url arbitrum_mainnet --broadcast

$ forge script script/arbitrum/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url arbitrum_mainnet --broadcast
$ forge script script/arbitrum/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url arbitrum_mainnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url arbitrum_mainnet --broadcast
```

Contract Address: [0x8fACfecfF4c84372faC9C852728E17683570AC53](https://arbiscan.io/address/0x8facfecff4c84372fac9c852728e17683570ac53)

### Deploy (Base)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url base_mainnet --broadcast

$ forge script script/base/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url base_mainnet --broadcast
$ forge script script/base/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url base_mainnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url base_mainnet --broadcast
```

Contract Address: [0x8fACfecfF4c84372faC9C852728E17683570AC53](https://basescan.org/address/0x8fACfecfF4c84372faC9C852728E17683570AC53)

### Deploy (BSC)

```shell
$ forge script script/DeployOneMillionCubes.s.sol:DeployOneMillionCubes --rpc-url bsc_mainnet --broadcast

$ forge script script/bsc/RegisterCubesGold.s.sol:RegisterCubesGold --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesSilver.s.sol:RegisterCubesSilver --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesBronze.s.sol:RegisterCubesBronze --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesPlatinum.s.sol:RegisterCubesPlatinum --rpc-url bsc_mainnet --broadcast
$ forge script script/bsc/RegisterCubesDiamond.s.sol:RegisterCubesDiamond --rpc-url bsc_mainnet --broadcast

$ forge script script/InitializeCubes.s.sol:InitializeCubes --rpc-url bsc_mainnet --broadcast
```

Contract Address: [0x8fACfecfF4c84372faC9C852728E17683570AC53](https://bscscan.com/address/0x8fACfecfF4c84372faC9C852728E17683570AC53)

### Interact with Contract

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

Get all selections made by a specific user:
```shell
$ cast call $CONTRACT_ADDRESS "getUserSelections(address)" $(cast wallet address $PRIVATE_KEY)
```

Get referral statistics for an address:
```shell
$ cast call $CONTRACT_ADDRESS "getReferralCount(address)" $REFERRER_ADDRESS
```