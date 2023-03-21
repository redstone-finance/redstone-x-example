// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@redstone-finance/evm-connector/contracts/mocks/AuthorisedMockSignersBase.sol";
import "../NoSlippageDex.sol";

contract MockNoSlippageDex is NoSlippageDex, AuthorisedMockSignersBase {
  function getUniqueSignersThreshold()
    public
    view
    virtual
    override
    returns (uint8)
  {
    return 2;
  }

  function getAuthorisedSignerIndex(
    address signerAddress
  ) public view virtual override returns (uint8) {
    return getAuthorisedMockSignerIndex(signerAddress);
  }
}
