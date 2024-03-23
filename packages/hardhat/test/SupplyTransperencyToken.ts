import { expect } from "chai";
import { ethers } from "hardhat";
import { SupplyTransperencyToken, SupplyTransperencyToken__factory } from "../typechain-types";
import { Signer } from "ethers";

describe("SupplyTransperencyToken", function () {
  let supplyTransperencyToken: SupplyTransperencyToken;
  let owner: Signer;
  let addr1: Signer;
  let addr2: Signer;

  beforeEach(async function () {
    // Preparação do ambiente de teste
    [owner, addr1, addr2] = await ethers.getSigners();
    const SupplyTransperencyTokenFactory: SupplyTransperencyToken__factory = await ethers.getContractFactory(
      "SupplyTransperencyToken",
    );
    supplyTransperencyToken = await SupplyTransperencyTokenFactory.deploy([addr1.getAddress(), addr2.getAddress()]);
  });

  it("Deve permitir a mintagem de um token se todas as assinaturas forem coletadas", async function () {
    const messageHash = ethers.keccak256(ethers.toUtf8Bytes("Test Message"));
    await supplyTransperencyToken.connect(addr1).addSignature(messageHash);
    await supplyTransperencyToken.connect(addr2).addSignature(messageHash);

    await expect(supplyTransperencyToken.safeMint(owner.getAddress(), messageHash)).to.emit(
      supplyTransperencyToken,
      "Transfer",
    );
  });

  it("Não deve permitir a mintagem sem todas as assinaturas", async function () {
    const messageHash = ethers.keccak256(ethers.toUtf8Bytes("Test Message"));
    await supplyTransperencyToken.connect(addr1).addSignature(messageHash);

    await expect(supplyTransperencyToken.safeMint(owner.getAddress(), messageHash)).to.be.revertedWith(
      "Transaction not fully signed",
    );
  });
});
