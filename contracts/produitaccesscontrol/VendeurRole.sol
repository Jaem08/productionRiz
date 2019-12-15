pragma solidity ^0.4.23;

// Import the library 'Roles'
import "@openzeppelin/contracts/access/Roles.sol";


contract VendeurRole {

    using Roles for Roles.Role;

    event VendeurAdded(address indexed account);
    event VendeurRemoved(address indexed account);

    Roles.Role private vendeurs;

    constructor() public {
        _addVendeur(msg.sender);
    }

    modifier onlyVendeur() {
        require(isVendeur(msg.sender), "Sender not authorized");
        _;
    }

    function isVendeur(address account) public view returns(bool) {
        return vendeurs.has(account);
    }

    function addVendeur(address account) public onlyVendeur {
        _addVendeur(account);
    }

    function renounceVendeur(address account) public onlyVendeur {
        _removeVendeur(account);
    }

    function _addVendeur(address account) internal {
        vendeurs.add(account);
        emit VendeurAdded(account);
    }

    function _removeVendeur(address account) internal {
        vendeurs.remove(account);
        emit VendeurRemoved(account);
    }
}
