// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin-contracts-5.0.2/access/Ownable.sol";
import "@openzeppelin-contracts-5.0.2/utils/cryptography/ECDSA.sol";
import "@openzeppelin-contracts-5.0.2/utils/cryptography/MessageHashUtils.sol";

/**
 * @title OneMillionCubes
 * @dev A contract for managing a cube-based game with different reward types.
 * Users can select cubes and claim rewards based on cube types.
 * The game includes mechanisms for cube registration, selection, and reward distribution.
 */
contract OneMillionCubes is Ownable {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;

    /// @notice Enum representing the different types of cubes
    enum CubeType {
        NONE,
        GOLD,
        SILVER,
        BRONZE,
        PLATINUM,
        DIAMOND
    }

    /// @notice Struct containing reward-related parameters
    struct RewardParameters {
        uint256 singleGoldReward;
        uint256 numOfGoldRewards;
        uint256 singleSilverReward;
        uint256 numOfSilverRewards;
        uint256 singleBronzeReward;
        uint256 numOfBronzeRewards;
        uint256 singlePlatinumReward;
        uint256 numOfPlatinumRewards;
        uint256 singleDiamondReward;
        uint256 numOfDiamondRewards;
    }

    /// @notice Struct containing game configuration parameters
    struct GameConfig {
        uint256 fee;
        uint256 minDiscElemNumb;
        uint256 blockNumber;
        uint256 totalElemNumb;
        uint256 maxSelectionsPerTx;
    }

    /// @notice Struct for keeping track of cube counts by type
    struct CubeCounts {
        uint256 gold;
        uint256 silver;
        uint256 bronze;
        uint256 platinum;
        uint256 diamond;
    }

    /// @notice Struct representing a user's cube selection
    struct Selection {
        uint256 x;
        uint256 y;
    }

    /// @notice Struct for batch cube registration
    struct CubeRegistration {
        bytes32 coordinateHash;
        CubeType cubeType;
    }

    mapping(bytes32 => CubeType) private cubes;
    /// @notice Mapping of user addresses to their cube selections
    mapping(address => Selection[]) private userSelections;
    /// @notice Mapping of coordinates to the address that selected them
    mapping(uint256 => mapping(uint256 => address)) private coordinateSelections;
    /// @notice Mapping to track if rewards have been claimed for a cube
    mapping(bytes32 => bool) public rewardsClaimed;
    /// @notice Struct to track referral stats for each address
    struct ReferralStats {
        uint256 referralCount;
        uint256 cubeSelections;
    }
    /// @notice Mapping to track referral stats for each address
    mapping(address => ReferralStats) private referralStats;

    /// @notice Game parameters set at contract deployment
    GameConfig public gameConfig;
    /// @notice Reward parameters set at contract deployment
    RewardParameters public rewardParameters;
    /// @notice Current count of registered cubes by type
    CubeCounts public cubeCounts;
    /// @notice Total number of cubes allowed in the game
    uint256 public totalAllowedCubes;
    /// @notice Total number of cube selections made
    uint256 public totalSelections;
    /// @notice Address of the admin signer for reward verification
    address public adminSigner;
    /// @notice Flag to track if the contract has been initialized
    bool public isInitialized;

    /// @notice Emitted when a new cube is registered
    event CubeRegistered(bytes32 indexed coordinateHash, CubeType cubeType);
    /// @notice Emitted when a user selects a cube
    event CubeSelected(address indexed user, uint256 x, uint256 y, uint256 fee);
    /// @notice Emitted when an emergency withdrawal is made
    event EmergencyWithdrawal(address indexed owner, uint256 amount);
    /// @notice Emitted when a user withdraws a reward
    event RewardWithdrawal(
        address indexed user,
        uint256 amount,
        bytes32 cubeHash
    );
    /// @notice Emitted when a cube is selected with a referral
    event CubeSelectedWithReferral(
        address indexed user,
        uint256 x,
        uint256 y,
        uint256 fee,
        address indexed referrer
    );

    // Custom errors
    error CubeAlreadyRegistered(bytes32 coordinateHash);
    error InvalidCubeType(CubeType cubeType);
    error AllCubesRegistered(CubeType cubeType);
    error InsufficientFee(uint256 providedFee, uint256 requiredFee);
    error CoordinateAlreadySelected();
    error WithdrawalTooEarly(uint256 currentBlock, uint256 requiredBlock);
    error WithdrawalFailed();
    error InsufficientSelections(
        uint256 currentSelections,
        uint256 requiredSelections
    );
    error InvalidSignature();
    error InvalidUser();
    error RewardAlreadyClaimed();
    error TooManySelections(uint256 selections);
    error NoSelections();
    error AlreadyInitialized();
    error ContractNotInitialized();

    /**
     * @notice Contract constructor
     * @param _gameConfig Initial game configuration parameters
     * @param _rewardParameters Initial reward parameters
     * @param _adminSigner Address of the admin signer for reward verification
     */
    constructor(
        GameConfig memory _gameConfig,
        RewardParameters memory _rewardParameters,
        address _adminSigner
    ) Ownable(msg.sender) {
        gameConfig = _gameConfig;
        rewardParameters = _rewardParameters;
        totalAllowedCubes =
            _rewardParameters.numOfGoldRewards +
            _rewardParameters.numOfSilverRewards +
            _rewardParameters.numOfBronzeRewards +
            _rewardParameters.numOfPlatinumRewards +
            _rewardParameters.numOfDiamondRewards;
        totalSelections = 0;
        adminSigner = _adminSigner;
        isInitialized = false;
    }

    /**
     * @notice Initialize the contract
     * @dev Can only be called by the owner and only once
     */
    function initialize() external onlyOwner {
        if (isInitialized) {
            revert AlreadyInitialized();
        }
        isInitialized = true;
    }

    /**
     * @notice Register multiple cubes in a single transaction
     * @param _registrations Array of CubeRegistration structs
     * @dev Only the contract owner can register cubes
     */
    function registerCubes(
        CubeRegistration[] calldata _registrations
    ) external onlyOwner {
        // Get current total registered cubes
        CubeCounts memory totalCounts = getTotalRegisteredCubes();
        uint256 totalRegistered = totalCounts.gold +
            totalCounts.silver +
            totalCounts.bronze +
            totalCounts.platinum +
            totalCounts.diamond;

        if (totalRegistered + _registrations.length > totalAllowedCubes) {
            revert AllCubesRegistered(CubeType.NONE);
        }

        for (uint256 i = 0; i < _registrations.length; i++) {
            if (cubes[_registrations[i].coordinateHash] != CubeType.NONE) {
                revert CubeAlreadyRegistered(_registrations[i].coordinateHash);
            }

            if (_registrations[i].cubeType == CubeType.NONE || 
                _registrations[i].cubeType > CubeType.DIAMOND) {
                revert InvalidCubeType(_registrations[i].cubeType);
            }

            _updateCubeCount(_registrations[i].cubeType);
            cubes[_registrations[i].coordinateHash] = _registrations[i].cubeType;

            emit CubeRegistered(
                _registrations[i].coordinateHash, 
                _registrations[i].cubeType
            );
        }
    }

    /**
     * @notice Allow a user to select multiple cubes
     * @param _selections Array of Selection structs containing coordinates
     * @param _referrer Address of the referrer
     */
    function selectCube(
        Selection[] calldata _selections,
        address _referrer
    ) external payable {
        if (!isInitialized) {
            revert ContractNotInitialized();
        }
        if (_selections.length > gameConfig.maxSelectionsPerTx) {
            revert TooManySelections(_selections.length);
        }
        if (_selections.length == 0) {
            revert NoSelections();
        }

        uint256 totalFee = gameConfig.fee * _selections.length;
        if (msg.value < totalFee) {
            revert InsufficientFee(msg.value, totalFee);
        }

        if (_referrer != address(0) && _referrer != msg.sender) {
            referralStats[_referrer].referralCount++;
        }

        for (uint256 i = 0; i < _selections.length; i++) {           
            if (coordinateSelections[_selections[i].x][_selections[i].y] != address(0)) {
                revert CoordinateAlreadySelected();
            }

            userSelections[msg.sender].push(_selections[i]);
            coordinateSelections[_selections[i].x][_selections[i].y] = msg.sender;
            totalSelections++;

            if (_referrer != address(0)) {
                referralStats[_referrer].cubeSelections++;
                emit CubeSelectedWithReferral(
                    msg.sender,
                    _selections[i].x,
                    _selections[i].y,
                    gameConfig.fee,
                    _referrer
                );
            } else {
                emit CubeSelected(msg.sender, _selections[i].x, _selections[i].y, gameConfig.fee);
            }
        }
    }

    /**
     * @notice Allow a user to withdraw their reward
     * @param _x X-coordinate of the selected cube
     * @param _y Y-coordinate of the selected cube
     * @param _cubeHash Hash of the cube's coordinates
     * @param _signature Signature from the admin signer verifying the reward
     */
    function rewardWithdraw(
        uint256 _x,
        uint256 _y,
        bytes32 _cubeHash,
        bytes memory _signature
    ) external {
        if (totalSelections < gameConfig.minDiscElemNumb) {
            revert InsufficientSelections(
                totalSelections,
                gameConfig.minDiscElemNumb
            );
        }

        if (coordinateSelections[_x][_y] != msg.sender) {
            revert InvalidUser();
        }

        if (rewardsClaimed[_cubeHash]) {
            revert RewardAlreadyClaimed();
        }

        if (
            !_verify(
                keccak256(abi.encodePacked(_x, _y, msg.sender, _cubeHash)),
                _signature,
                adminSigner
            )
        ) {
            revert InvalidSignature();
        }

        uint256 reward;
        if (cubes[_cubeHash] == CubeType.GOLD) {
            reward = rewardParameters.singleGoldReward;
        } else if (cubes[_cubeHash] == CubeType.SILVER) {
            reward = rewardParameters.singleSilverReward;
        } else if (cubes[_cubeHash] == CubeType.BRONZE) {
            reward = rewardParameters.singleBronzeReward;
        } else if (cubes[_cubeHash] == CubeType.PLATINUM) {
            reward = rewardParameters.singlePlatinumReward;
        } else if (cubes[_cubeHash] == CubeType.DIAMOND) {
            reward = rewardParameters.singleDiamondReward;
        } else {
            revert InvalidCubeType(cubes[_cubeHash]);
        }

        rewardsClaimed[_cubeHash] = true;

        (bool sent, ) = payable(msg.sender).call{value: reward}("");
        if (!sent) {
            revert WithdrawalFailed();
        }

        emit RewardWithdrawal(msg.sender, reward, _cubeHash);
    }

    /**
     * @notice Allow the owner to withdraw all funds in case of emergency
     * @dev Can only be called after the specified block number in game parameters
     */
    function emergencyWithdraw() external onlyOwner {
        if (block.number < gameConfig.blockNumber) {
            revert WithdrawalTooEarly(block.number, gameConfig.blockNumber);
        }

        uint256 balance = address(this).balance;
        (bool sent, ) = payable(msg.sender).call{value: balance}("");
        if (!sent) {
            revert WithdrawalFailed();
        }

        emit EmergencyWithdrawal(msg.sender, balance);
    }

    /**
     * @notice Get the total number of registered cubes by type
     * @return CubeCounts struct with the count of each cube type
     */
    function getTotalRegisteredCubes() public view returns (CubeCounts memory) {
        return cubeCounts;
    }

    /**
     * @notice Get all selections made by a specific user
     * @param _user Address of the user
     * @return Array of Selection structs representing the user's selections
     */
    function getUserSelections(
        address _user
    ) external view returns (Selection[] memory) {
        return userSelections[_user];
    }

    /**
     * @notice Get the addresses of users who selected specific coordinates
     * @param _selections Array of Selection structs containing coordinates
     * @return Array of addresses who selected the coordinates
     */
    function getCoordinateSelectors(
        Selection[] calldata _selections
    ) external view returns (address[] memory) {
        address[] memory selectors = new address[](_selections.length);
        
        for (uint256 i = 0; i < _selections.length; i++) {
            selectors[i] = coordinateSelections[_selections[i].x][_selections[i].y];
        }
        
        return selectors;
    }

    /**
     * @notice Get the type of a cube given its coordinate hash
     * @param _coordinateHash Hash of the cube's coordinates
     * @return CubeType enum representing the type of the cube
     */
    function getCube(bytes32 _coordinateHash) external view returns (CubeType) {
        return cubes[_coordinateHash];
    }

    /**
     * @notice Get referral statistics for a given address
     * @param _referrer Address of the referrer
     * @return referralCount Number of times the address was used as a referral
     * @return cubesSelectedWithReferral Number of cubes selected when this address was provided as referrer
     */
    function getReferralCount(
        address _referrer
    ) external view returns (uint256 referralCount, uint256 cubesSelectedWithReferral) {
        return (referralStats[_referrer].referralCount, referralStats[_referrer].cubeSelections);
    }

    /**
     * @notice Update the count of cubes for a specific type
     * @param _cubeType Type of cube to update the count for
     * @dev This function is called internally when registering a new cube
     */
    function _updateCubeCount(CubeType _cubeType) internal {
        if (_cubeType == CubeType.GOLD) {
            if (cubeCounts.gold >= rewardParameters.numOfGoldRewards) {
                revert AllCubesRegistered(CubeType.GOLD);
            }
            cubeCounts.gold++;
        } else if (_cubeType == CubeType.SILVER) {
            if (cubeCounts.silver >= rewardParameters.numOfSilverRewards) {
                revert AllCubesRegistered(CubeType.SILVER);
            }
            cubeCounts.silver++;
        } else if (_cubeType == CubeType.BRONZE) {
            if (cubeCounts.bronze >= rewardParameters.numOfBronzeRewards) {
                revert AllCubesRegistered(CubeType.BRONZE);
            }
            cubeCounts.bronze++;
        } else if (_cubeType == CubeType.PLATINUM) {
            if (cubeCounts.platinum >= rewardParameters.numOfPlatinumRewards) {
                revert AllCubesRegistered(CubeType.PLATINUM);
            }
            cubeCounts.platinum++;
        } else if (_cubeType == CubeType.DIAMOND) {
            if (cubeCounts.diamond >= rewardParameters.numOfDiamondRewards) {
                revert AllCubesRegistered(CubeType.DIAMOND);
            }
            cubeCounts.diamond++;
        }
    }

    /**
     * @notice Verify the signature for reward withdrawal
     * @param data Hashed data to verify
     * @param signature Signature to verify
     * @param account Address of the signer
     * @return bool indicating whether the signature is valid
     */
    function _verify(
        bytes32 data,
        bytes memory signature,
        address account
    ) internal pure returns (bool) {
        return data.toEthSignedMessageHash().recover(signature) == account;
    }
}
