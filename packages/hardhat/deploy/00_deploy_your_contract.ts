import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

/**
 * Deploys the SupplyTransperencyToken contract using the deployer account and
 * constructor arguments set to an array of signer addresses.
 *
 * @param hre HardhatRuntimeEnvironment object.
 */
const deploySupplyTransperencyToken: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  // Replace 'signerAddresses' with the actual addresses of the signers for your contract.
  const signerAddresses = ["0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199", "0xdD2FD4581271e230360230F9337D5c0430Bf44C0"];

  await deploy("SupplyTransperencyToken", {
    from: deployer,
    // Adjust constructor arguments as needed. If signer addresses are dynamic, they need to be set accordingly.
    args: [signerAddresses],
    log: true,
    autoMine: true,
  });

  // Optionally, interact with the contract after deploying
  const supplyTransperencyToken = await hre.ethers.getContract<Contract>("SupplyTransperencyToken", deployer);
  console.log("SupplyTransperencyToken deployed to:", supplyTransperencyToken.address);
};

export default deploySupplyTransperencyToken;
deploySupplyTransperencyToken.tags = ["SupplyTransperencyToken"];
