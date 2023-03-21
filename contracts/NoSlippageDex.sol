// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@redstone-finance/evm-connector/contracts/data-services/MainDemoConsumerBase.sol";

contract NoSlippageDex is MainDemoConsumerBase {
  uint256 private constant MULTIPLIER = 1e8;
  uint256 expectedBlock;

  struct SwapRequestDetails {
    uint256 amountFrom;
    uint256 amountTo;
    uint256 maxSlippage;
    address fromToken;
    address toToken;
  }

  // TODO: add mapping from tokens to bytes32
  // TODO: override function for timestamp validation (it will validate the block number instead)

  // TODO: remove
  /**
   * Returns the latest price of STX stocks
   */
  function getLatestStxPrice() public view returns (uint256) {
    bytes32 dataFeedId = bytes32("STX");
    return getOracleNumericValueFromTxMsg(dataFeedId);
  }

  function requestSwap(SwapRequestDetails calldata swapRequestDetails) public {
    bytes32 requestHash = calculateRequestHash(
      swapRequestDetails,
      msg.sender,
      block.number
    );
    requestHash;
    // TODO: save request in request set, first checking if it's not saved already
    // TODO: maybe add additional checks, e.g. require allowance on token to swap
  }

  function executeSwap(
    SwapRequestDetails calldata swapRequestDetails,
    address requestTxSender,
    uint256 requestTxBlockNumber
  ) public {
    bytes32 requestHash = calculateRequestHash(
      swapRequestDetails,
      requestTxSender,
      requestTxBlockNumber
    );

    requestHash;

    // Extract oracle price for the swap
    expectedBlock = requestTxBlockNumber; // For validating timestamp (block number actually) in redstone payload
    uint256 priceOfTokenFrom = getOracleNumericValueFromTxMsg(bytes32("ETH"));
    uint256 priceOfTokenTo = getOracleNumericValueFromTxMsg(bytes32("USDC"));
    expectedBlock = 0; // For gas refund
    uint256 price = (priceOfTokenFrom * MULTIPLIER) / priceOfTokenTo;

    // Calculate the final amount (including fee)
    // TODO: implement

    // Check if swapRequestDetails.maxSlippage fits
    // TODO: implement

    // Execute transfers
    // TODO: implement
  }

  function calculateRequestHash(
    SwapRequestDetails calldata swapRequestDetails,
    address requestTxSender,
    uint256 requestTxBlockNumber
  ) public pure returns (bytes32) {
    return
      keccak256(
        abi.encode(swapRequestDetails, requestTxSender, requestTxBlockNumber)
      );
  }
}
