// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CartorioDigital {
    string public CidForms;
    string public CidDoc;
    bool public isSigned = false;

    constructor() {
        isSigned = false; // inicialmente não assinado
    }

    // Função para assinar o contratoForn

    function setCidForms(string memory _CidForms) public {
        CidForms = _CidForms;
    }

    function setCidDoc(string memory _CidDoc) public {
        CidDoc = _CidDoc;
    }

    function signContract() public {
        require(bytes(CidDoc).length > 0, "CidDoc nao pode ser vazio.");
        require(!isSigned, "Contrato ja assinado.");
        isSigned = true;
    }

}