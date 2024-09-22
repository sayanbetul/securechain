// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityVerification {
    struct User {
        bool isVerified;
        uint securityScore;
        address userAddress;
    }

    mapping(address => User) public users;
    address public admin;

    event UserVerified(address indexed user, uint score);
    event UserScoreUpdated(address indexed user, uint newScore);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Kullanıcının kimliğini doğrular ve başlangıç güvenlik puanını atar
    function verifyUser(address _user, uint _initialScore) external onlyAdmin {
        require(!users[_user].isVerified, "User is already verified");
        users[_user] = User(true, _initialScore, _user);
        emit UserVerified(_user, _initialScore);
    }

    // Kullanıcının güvenlik puanını günceller
    function updateSecurityScore(address _user, uint _newScore) external onlyAdmin {
        require(users[_user].isVerified, "User is not verified");
        users[_user].securityScore = _newScore;
        emit UserScoreUpdated(_user, _newScore);
    }

    // Kullanıcının güvenlik puanını getirir
    function getSecurityScore(address _user) external view returns (uint) {
        require(users[_user].isVerified, "User is not verified");
        return users[_user].securityScore;
    }

    // Kullanıcının doğrulanmış olup olmadığını kontrol eder
    function isUserVerified(address _user) external view returns (bool) {
        return users[_user].isVerified;
    }
}
