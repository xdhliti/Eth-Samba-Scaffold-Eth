import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";
/**
 * Deploys the SupplyTransperencyToken contract using the deployer account and
 * constructor arguments set to an array of signer addresses.
 *
 * @param hre HardhatRuntimeEnvironment object.
 */
const deployCartorioDigital: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  await deploy("CartorioDigital", {
    from: deployer,
    args: [],
    log: true,
    autoMine: true,
  });

  // Optionally, interact with the contract after deploying
  const cartorioDigital = await hre.ethers.getContract<Contract>("CartorioDigital", deployer);
  const address = await cartorioDigital.getAddress();
  console.log("CartorioDigital deployed to:", address);
};

export default deployCartorioDigital;

deployCartorioDigital.tags = ["CartorioDigital"];
