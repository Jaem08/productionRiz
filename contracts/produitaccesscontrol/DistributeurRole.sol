pragma solidity ^0.4.23;

// Import the library 'Roles'
import "@openzeppelin/contracts/access/Roles.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";



contract DistributeurRole {

    using Roles for Roles.Role;

    event DistributeurAdded(address indexed account);
    event DistributeurRemoved(address indexed account);

    Roles.Role private distributeurs;

    constructor() public {
        _addDistributeur(msg.sender);
    }

    modifier onlyDistributeur() {
        require(isDistributeur(msg.sender), "Sender not authorized");
        _;
    }

    function isDistributeur(address account) public view returns(bool) {
        return distributeurs.has(account);
    }

    function addDistributeur(address account) public onlyDistributeur {
        _addDistributeur(account);
    }

    function renounceDistributeur(address account) public onlyDistributeur {
        _removeDistributeur(account);
    }

    function _addDistributeur(address account) internal {
        distributeurs.add(account);
        emit DistributeurAdded(account);
    }

    function _removeDistributeur(address account) internal {
        distributeurs.remove(account);
        emit DistributeurRemoved(account);
    }
}
