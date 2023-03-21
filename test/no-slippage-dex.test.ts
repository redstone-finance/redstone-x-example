import chai, { expect } from "chai";
import chaiAsPromised from "chai-as-promised";
import { ethers } from "hardhat";
import { WrapperBuilder } from "@redstone-finance/evm-connector";

chai.use(chaiAsPromised);

describe("NoSlippageDex", () => {
  it("Should deploy and test", async () => {
    // Deploy contract
    const NoSlippageDexFactory = await ethers.getContractFactory(
      "MockNoSlippageDex"
    );
    const contract = await NoSlippageDexFactory.deploy();
    await contract.deployed();

    // Wrap contract
    const wrappedContract = WrapperBuilder.wrap(
      contract
    ).usingSimpleNumericMock({
      dataPoints: [{ dataFeedId: "STX", value: 42 }],
      mockSignersCount: 3,
      timestampMilliseconds: Date.now(),
    });

    // Get oracle value
    const stxPrice = await wrappedContract.getLatestStxPrice();

    // Validate oracle value
    expect(stxPrice.toNumber()).to.eq(42 * 10 ** 8);
  });

  it("Should deploy NoSlippageDex", async () => {});
});
