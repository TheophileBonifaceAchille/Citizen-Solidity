// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;
import "./CitizenErc20.sol";

contract Citizen {
    CitizenErc20 public token;

    address payable etat;

    /// @dev struct Citoyen
    struct Citoyen {
        bool isSage; // false if the member is not an sage, true is an sage
        bool workeur; // false if the workeur is not an sage, true is an workeur
        bool jobless; // false if the jobless is not an sage, true is an jobless
        bool banned; //
        uint256 age; // for pension retreat
        uint256 idEnterprise; // for workeur true, and jobless false and inverse
        uint256 wallet; // wallet Citoyen
    }

    /// @dev struct Proposal
    struct Compagnie {
        uint256 id; // id Compagnie
        uint256 wallet; // wallet Compagnie
        bool statut; // expecting citizen's vote
    }

    /// @dev struct Taxe
    struct Taxe {
        uint256 impot;
        uint256 chomage;
        uint256 maladie;
        uint256 retraite;
        uint256 deces;
    }

    // mapping

    /// @dev mapping from an address to a Member
    mapping(address => Citoyen) public citoyen;

    /// @dev mapping from an address to a Member
    mapping(address => Compagnie) public compagnie;

    // Modifier

    modifier onlySage() {
        require(
            citoyen[msg.sender].isSage == true,
            "only sage can call this function"
        );
        _;
    }

    // Fonction

    // 100 citizen attribué par citoyen crée
    function addCitoyen(address _addr) public onlySage {
        // Sage aprouve un citoyen dans le pay
    }

    // Rajouter un vote pour que les citoyens elisent un sage ou le blacklist
    // setSage met en depot 100 citizen
    // Election dur 1 semaine

    function setSage(address _addr) public onlySage {
        citoyen[_addr].isSage = true;
    }

    function unsetSage(address _addr) public onlySage {
        citoyen[_addr].isSage = false;
    }

    // Rajouter un vote pour que les sages approuvent une entreprise et la créent

    // Dans cet état les peines consistent à se faire retirer du CITIZEN. 4 types de peines: légère -5 citizen,
    // lourde -50, grave -100, crime contre la nation 10 ans de ban et citizen 0.
}
