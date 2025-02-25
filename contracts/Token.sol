// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {ERC20Upgradeable} from "./ERC20Upgradeable.sol";
import {ERC20PermitUpgradeable} from "./ERC20PermitUpgradeable.sol";
import {ERC20PausableUpgradeable} from "./ERC20PausableUpgradeable.sol";


import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ContextUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Token is Initializable, ERC20Upgradeable, ERC20PermitUpgradeable, ERC20PausableUpgradeable, OwnableUpgradeable, UUPSUpgradeable {

    event TransferChanged(address account);

    function initialize() initializer public {
        __ERC20_init("Next Vault Coin", "NV", msg.sender);
        __ERC20Pausable_init();
        __Ownable_init(msg.sender);
        __ERC20Permit_init("Token");
        __UUPSUpgradeable_init();
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    // Pause the contract
    function pause() public onlyOwner {
        _pause();
    }

    // Unpause the contract
    function unpause() public onlyOwner {
        _unpause();
    }

    // Set the manager address
    function setManagerAddress(address manager) public onlyOwner {
        _setManageAddress(manager);
    }

    // Set the NV public chain launch status
    function setLaunchChain() public onlyOwner {
        _setLaunchChain();
    }

    // Set the lock address for the public chain by self
    function setLockAddress(string memory moveAddress) public {
        _setLockAddress(msg.sender, moveAddress);
    }

    // Set the unlock address for the public chain by owner
    function setUnlockAddress(address account) public onlyOwner {
        _setUnlockAddress(account);
    }

    // Authorize the upgrade
    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}

    // The following functions are overrides required by Solidity.
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20Upgradeable, ERC20PausableUpgradeable)
    {
        super._update(from, to, value);
    }
}
