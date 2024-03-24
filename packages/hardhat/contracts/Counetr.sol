// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint[] public tokenIds;
    uint private counter = 0;
    ContractDTO contr;
    ContractDTO[] public contracts;

    //mapping(address => string) public reqOwner;

    struct ContractDTO {
        string content;
        address ownerCon;
    }

    
    function addContract(address rOwner, string memory cont) public {
        ContractDTO memory newContract = ContractDTO({
            content: cont,
            ownerCon: rOwner
        });
        contracts.push(newContract);
    }

    function getAllMyContracts(address sentOwner) public view returns (ContractDTO[] memory){
        uint totalItemCount = contracts.length;      
        uint itemCount = 0;

        for (uint i = 0; i < totalItemCount; i++) {
            if (contracts[i].ownerCon == sentOwner) {
                itemCount++;
            }
        }

        ContractDTO[] memory items = new ContractDTO[](itemCount);
        uint currentIndex = 0;

        for (uint i = 0; i < totalItemCount; i++) {
            if (contracts[i].ownerCon == sentOwner) {
                items[currentIndex] = contracts[i];
                currentIndex++;
            }
        }

        return items;
    }
}
