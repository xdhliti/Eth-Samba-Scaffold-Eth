import { expect } from "chai";
import { ethers } from "hardhat";

describe("CartorioDigital", function () {
  it("Deve ser possível assinar o contrato", async function () {
    // Deploy do contrato
    const CartorioDigital = await ethers.getContractFactory("CartorioDigital");
    const cartorio = await CartorioDigital.deploy();

    // Setar CidForms e CidDoc
    await cartorio.setCidForms("exampleCidForms");
    await cartorio.setCidDoc("exampleCidDoc");

    // Assinar o contrato
    await cartorio.signContract();

    // Verificações
    expect(await cartorio.isSigned()).to.equal(true);
    expect(await cartorio.CidForms()).to.equal("exampleCidForms");
    expect(await cartorio.CidDoc()).to.equal("exampleCidDoc");
  });
});
