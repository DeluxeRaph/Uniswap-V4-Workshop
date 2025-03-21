// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IHooks} from "v4-core/src/interfaces/IHooks.sol";
import {Currency} from "v4-core/src/types/Currency.sol";

/// @notice Shared configuration between scripts
/// @dev This file serves as a central source of truth for contract addresses and parameters
/// Contains:
///      - Test token addresses for local development
///      - Hook contract addresses and parameters 
///      - Currency type wrappers for proper token handling
/// Used by deployment scripts like Anvil.s.sol to ensure consistent settings
/// Makes scripts more maintainable by reducing duplicate configuration
contract Config {
    /// @dev populated with default anvil addresses
    IERC20 constant token0 = IERC20(address(0x0165878A594ca255338adfa4d48449f69242Eb8F));
    IERC20 constant token1 = IERC20(address(0xa513E6E4b8f2a923D98304ec87F64353C4D5C853));
    IHooks constant hookContract = IHooks(address(0x0));

    // @notice Currency type is required for Foundry scripts to properly handle token addresses during deployment
    // @dev Currency.wrap() provides type safety by converting raw addresses into strongly typed identifiers
    // This ensures tokens are handled correctly when deploying contracts and prevents address mixups
    Currency constant currency0 = Currency.wrap(address(token0));
    Currency constant currency1 = Currency.wrap(address(token1));
}
