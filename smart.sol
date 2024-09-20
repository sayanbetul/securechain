// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractSecurityCheck {
    address public admin;

    struct SmartContract {
        bool isVerified;
        uint securityScore;
        string contractDetails;
    }

    mapping(address => SmartContract) public smartContracts;

    event ContractVerified(address indexed contractAddress, uint score);
    event ContractReported(address indexed contractAddress, uint newScore);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Akıllı sözleşmenin güvenli olduğunu doğrular ve bir güvenlik puanı atar
    function verifyContract(address _contract, uint _initialScore, string memory _details) external onlyAdmin {
        require(!smartContracts[_contract].isVerified, "Contract is already verified");
        smartContracts[_contract] = SmartContract(true, _initialScore, _details);
        emit ContractVerified(_contract, _initialScore);
    }

    // Sözleşmenin güvenlik puanını günceller
    function reportContract(address _contract, uint _newScore) external onlyAdmin {
        require(smartContracts[_contract].isVerified, "Contract is not verified");
        smartContracts[_contract].securityScore = _newScore;
        emit ContractReported(_contract, _newScore);
    }

    // Akıllı sözleşmenin güvenli olup olmadığını kontrol eder
    function isContractVerified(address _contract) external view returns (bool) {
        return smartContracts[_contract].isVerified;
    }

    // Akıllı sözleşmenin güvenlik puanını getirir
    function getContractSecurityScore(address _contract) external view returns (uint) {
        require(smartContracts[_contract].isVerified, "Contract is not verified");
        return smartContracts[_contract].securityScore;
    }

    // Akıllı sözleşmenin detaylarını getirir
    function getContractDetails(address _contract) external view returns (string memory) {
        require(smartContracts[_contract].isVerified, "Contract is not verified");
        return smartContracts[_contract].contractDetails;
    }
}
