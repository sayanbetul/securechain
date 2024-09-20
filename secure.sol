// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MFAToken {
    address public admin;

    mapping(address => uint256) public mfaTokens;

    event MFATokenGenerated(address indexed user, uint256 token);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can generate tokens");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Kullanıcıya MFA token oluşturur
    function generateMFAToken(address _user) external onlyAdmin {
        uint256 token = uint256(keccak256(abi.encodePacked(_user, block.timestamp)));
        mfaTokens[_user] = token;
        emit MFATokenGenerated(_user, token);
    }

    // Kullanıcının MFA tokenini getirir
    function getMFAToken(address _user) external view returns (uint256) {
        return mfaTokens[_user];
    }

    // MFA tokenin doğru olup olmadığını doğrular
    function verifyMFAToken(address _user, uint256 _token) external view returns (bool) {
        return mfaTokens[_user] == _token;
    }
}
