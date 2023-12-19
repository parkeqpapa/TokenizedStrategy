pragma solidity ^0.8.10;

interface ConvexRewardPool {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event EmergencyWithdrawn(address indexed _user, uint256 _amount);
    event RewardAdded(address indexed _rewardToken);
    event RewardInvalidated(address _rewardToken);
    event RewardPaid(
        address indexed _user, address indexed _rewardToken, address indexed _receiver, uint256 _rewardAmount
    );
    event RewardRedirected(address indexed _account, address _forward);
    event Staked(address indexed _user, uint256 _amount);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Withdrawn(address indexed _user, uint256 _amount);

    struct EarnedData {
        address token;
        uint256 amount;
    }

    function addExtraReward(address _token) external;
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function claimable_reward(address, address) external view returns (uint256);
    function convexBooster() external view returns (address);
    function convexPoolId() external view returns (uint256);
    function convexStaker() external view returns (address);
    function crv() external view returns (address);
    function curveGauge() external view returns (address);
    function decimals() external pure returns (uint8);
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
    function earned(address _account) external returns (EarnedData[] memory claimable);
    function emergencyWithdraw(uint256 _amount) external returns (bool);
    function getReward(address _account, address _forwardTo) external;
    function getReward(address _account) external;
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    function initialize(
        address _crv,
        address _curveGauge,
        address _convexStaker,
        address _convexBooster,
        address _lptoken,
        uint256 _poolId
    ) external;
    function invalidateReward(address _token) external;
    function maxRewards() external view returns (uint256);
    function name() external view returns (string memory);
    function rewardHook() external view returns (address);
    function rewardLength() external view returns (uint256);
    function rewardMap(address) external view returns (uint256);
    function rewardRedirect(address) external view returns (address);
    function reward_integral_for(address, address) external view returns (uint256);
    function rewards(uint256)
        external
        view
        returns (address reward_token, uint128 reward_integral, uint128 reward_remaining);
    function setRewardHook(address _hook) external;
    function setRewardRedirect(address _to) external;
    function stakeFor(address _for, uint256 _amount) external returns (bool);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function user_checkpoint(address _account) external returns (bool);
    function withdraw(uint256 _amount, bool _claim) external returns (bool);
    function withdrawAll(bool claim) external;
}

interface Booster {
    event CrvFactorySet(address indexed _factory, address _crv);
    event Deposited(address indexed user, uint256 indexed poolid, uint256 amount);
    event OwnerChanged(address indexed _address);
    event SetPendingOwner(address indexed _address);
    event Withdrawn(address indexed user, uint256 indexed poolid, uint256 amount);

    function FEE_DENOMINATOR() external view returns (uint256);
    function MaxFees() external view returns (uint256);
    function acceptPendingOwner() external;
    function activeMap(address) external view returns (bool);
    function addPool(address _lptoken, address _gauge, address _factory) external returns (bool);
    function calculatePlatformFees(uint256 _amount) external view returns (uint256);
    function claimCrv(uint256 _pid, address _gauge) external;
    function deposit(uint256 _pid, uint256 _amount) external returns (bool);
    function depositAll(uint256 _pid) external returns (bool);
    function factoryCrv(address) external view returns (address);
    function feeDeposit() external view returns (address);
    function fees() external view returns (uint256);
    function isShutdown() external view returns (bool);
    function owner() external view returns (address);
    function pendingOwner() external view returns (address);
    function poolInfo(uint256)
        external
        view
        returns (address lptoken, address gauge, address rewards, bool shutdown, address factory);
    function poolLength() external view returns (uint256);
    function poolManager() external view returns (address);
    function rescueManager() external view returns (address);
    function rescueToken(address _token, address _to) external;
    function rewardFactory() external view returns (address);
    function rewardManager() external view returns (address);
    function setFactoryCrv(address _factory, address _crv) external;
    function setFeeDeposit(address _deposit) external;
    function setFees(uint256 _platformFees) external;
    function setPendingOwner(address _po) external;
    function setPoolManager(address _poolM) external;
    function setRescueManager(address _rescueM) external;
    function setRewardFactory(address _rfactory) external;
    function setRewardManager(address _rewardM) external;
    function shutdownBalances(uint256) external view returns (uint256);
    function shutdownPool(uint256 _pid) external returns (bool);
    function shutdownSystem() external;
    function staker() external view returns (address);
    function withdrawTo(uint256 _pid, uint256 _amount, address _to) external returns (bool);
}