pragma solidity ^0.4.23;

// Import the library 'Roles'
import "@openzeppelin/contracts/access/Roles.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


contract ClientRole {

    using Roles for Roles.Role;

    event ClientAdded(address indexed account);
    event ClientRemoved(address indexed account);

    Roles.Role private clients;

    constructor() public {
        _addClient(msg.sender);
    }

    modifier onlyClient() {
        require(isClient(msg.sender), "Sender not authorized");
        _;
    }

    function isClient(address account) public view returns(bool) {
        return clients.has(account);
    }

    function addClient(address account) public onlyClient {
        _addClient(account);
    }

    function renounceClient(address account) public onlyClient {
        _removeClient(account);
    }

    function _addClient(address account) internal {
        clients.add(account);
        emit ClientAdded(account);
    }

    function _removeClient(address account) internal {
        clients.remove(account);
        emit ClientRemoved(account);
    }
}
