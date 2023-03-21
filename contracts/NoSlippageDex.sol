// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@redstone-finance/evm-connector/contracts/data-services/MainDemoConsumerBase.sol";

contract NoSlippageDex is MainDemoConsumerBase {
    /**
     * Returns the latest price of STX stocks
     */
    function getLatestStxPrice() public view returns (uint256) {
        bytes32 dataFeedId = bytes32("STX");
        return getOracleNumericValueFromTxMsg(dataFeedId);
    }
}
