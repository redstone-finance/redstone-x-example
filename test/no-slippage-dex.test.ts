import chai, { expect } from "chai";
import chaiAsPromised from "chai-as-promised";
import { ethers } from "hardhat";
import { WrapperBuilder } from "@redstone-finance/evm-connector";

chai.use(chaiAsPromised);

describe("NoSlippageDex", () => {
  it("Should deploy and test", async () => {
    const NoSlippageDexFactory = await ethers.getContractFactory(
      "MockNoSlippageDex"
    );
    const contract = await NoSlippageDexFactory.deploy();

    await contract.deployed();

    const wrappedContract = WrapperBuilder.wrap(
      contract
    ).usingSimpleNumericMock({
      dataPoints: [{ dataFeedId: "STX", value: 42 }],
      mockSignersCount: 3,
      timestampMilliseconds: Date.now(),
    });

    const stxPrice = await wrappedContract.getLatestStxPrice();

    expect(stxPrice.toNumber()).to.eq(42 * 10 ** 8);
  });
});
