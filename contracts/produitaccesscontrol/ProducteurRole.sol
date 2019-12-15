pragma solidity ^0.4.23;

// Import the library 'Roles'
import "@openzeppelin/contracts/access/Roles.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


contract ProducteurRole {

    using Roles for Roles.Role;

    event ProducteurAdded(address indexed account);
    event ProducteurRemoved(address indexed account);

    Roles.Role private producteurs;

    constructor() public {
        _addProducteur(msg.sender);
    }

    modifier onlyProducteur() {
        require(isProducteur(msg.sender), "Sender not authorized");
        _;
    }

    function isProducteur(address account) public view returns(bool) {
        return producteurs.has(account);
    }

    function addProducteur(address account) public onlyProducteur {
        _addProducteur(account);
    }

    function renounceProducteur(address account) public onlyProducteur {
        _removeProducteur(account);
    }

    function _addProducteur(address account) internal {
        producteurs.add(account);
        emit ProducteurAdded(account);
    }

    function _removeProducteur(address account) internal {
        producteurs.remove(account);
        emit ProducteurRemoved(account);
    }
}
