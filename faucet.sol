// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ERC20标准接口
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract ERC20Faucet {
    // 水龙头分发的代币数量
    uint256 public constant DRIP_AMOUNT = 100 * 10**18; // 假设18位小数，发送100个代币，可调整
    // 冷却时间(24小时)
    uint256 public constant COOLDOWN = 24 hours;
    // ERC20代币合约地址
    IERC20 public token;
    // 合约拥有者
    address public owner;
    
    // 记录每个地址最后领取的时间
    mapping(address => uint256) public lastClaimTime;
    
    // 事件
    event Claimed(address indexed user, uint256 amount);
    event Deposited(address indexed from, uint256 amount);
    
    // 构造函数，传入代币地址
    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
        owner = msg.sender;
    }
    
    // 修饰符：限制只有拥有者能调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 领取代币函数
    function claim() external {
        address user = msg.sender;
        
        // 检查冷却时间
        require(
            block.timestamp >= lastClaimTime[user] + COOLDOWN,
            "Please wait 24 hours between claims"
        );
        
        // 检查合约代币余额
        require(
            token.balanceOf(address(this)) >= DRIP_AMOUNT,
            "Faucet is out of tokens"
        );
        
        // 更新最后领取时间
        lastClaimTime[user] = block.timestamp;
        
        // 发送代币
        require(
            token.transfer(user, DRIP_AMOUNT),
            "Token transfer failed"
        );
        
        emit Claimed(user, DRIP_AMOUNT);
    }
    
    // 存入代币到水龙头(需要先approve)
    function deposit(uint256 amount) external {
        require(amount > 0, "Deposit amount must be greater than 0");
        require(
            token.transferFrom(msg.sender, address(this), amount),
            "TransferFrom failed"
        );
        emit Deposited(msg.sender, amount);
    }
    
    // 提取所有代币(仅限拥有者)
    function withdraw(uint256 amount) external onlyOwner {
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(
            token.transfer(owner, amount),
            "Withdraw failed"
        );
    }
    
    // 查看合约代币余额
    function getBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }
    
    // 查看用户下次可领取时间
    function nextClaimTime(address user) external view returns (uint256) {
        return lastClaimTime[user] + COOLDOWN;
    }
}
