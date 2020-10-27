// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;
import "./CitizenErc20.sol";

contract Citizen {
    address payable etat;

    CitizenErc20 public token;

    address private _sage1;
    address private _sage2;
    address private _sage3;

    constructor(
        address payable _addr,
        address payable sage1,
        address payable sage2,
        address payable sage3
    ) public {
        etat = _addr;
        _sage1 = sage1;
        _sage2 = sage2;
        _sage3 = sage3;
    }

    /// @dev struct Citoyen
    struct Citoyen {
        bool isSage; // false if the member is not an sage, true is an sage
        uint256 voteJudge; // if 3 sage approve, isJudge = true
        bool isJudge; // false if the member is not an judge, true is an judge
        bool workeur; // false if the workeur is not an sage, true is an workeur
        bool jobless; // false if the jobless is not an sage, true is an jobless
        bool banned; // banned with timestamp
        uint256 age; // for pension retreat
        uint256 idEnterprise; // for workeur true, and jobless false and inverse
        int256 wallet; // wallet Citoyen
        mapping(address => bool) didVote; // mapping to check that an address can not vote twice
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

    /// @dev mapping from an address to a Member
    mapping(address => Citoyen) public citoyen;

    /// @dev mapping from an address to a Compagnie
    mapping(address => Compagnie) public compagnie;

    /// @dev mapping from an address to a Taxe
    mapping(address => Taxe) public taxe;

    /// @dev modifier for Sage function
    modifier onlySage() {
        require(
            citoyen[msg.sender].isSage == true,
            "only Judge can call this function"
        );
        _;
    }

    /// @dev modifier for Judge function
    modifier onlyJudge() {
        require(
            citoyen[msg.sender].isJudge == true,
            "only Judge can call this function"
        );
        _;
    }

    /// @dev add citoyen
    function addCitoyen(address _addr) public onlySage {
        // 100 citizen attribué par citoyen crée
        // Sage aprouve un citoyen dans le pay
    }

    /// @dev Sage elected
    function setSage(address _addr) public onlySage {
        citoyen[_addr].isSage = true;
    }

    /// @dev Sage kicked
    function unsetSage(address _addr) public onlySage {
        citoyen[_addr].isSage = false;
    }

    /// @dev enum pain
    enum Peines {legere, lourde, grave, crime}

    function addJudge(address _addr) public onlySage {
        citoyen[_addr].voteJudge += 1;
        if (citoyen[_addr].voteJudge > 1) {
            citoyen[_addr].isJudge = true;
        }
    }

    /// @dev Option court
    string
        public sentence = "0 => -5 Citizen, 1 => -10 Citizen, 2 => -100 Citizen, 3 => banned for 10 years, and wallet = 0";

    /// @dev court of pain
    function peinesCitizen(address _addr, Peines _peines) public onlyJudge {
        (_addr != etat, "etat cannot be judgement !");
        if (_peines == Peines.legere) {
            citoyen[_addr].wallet -= 5 * 10**18;
        } else if (_peines == Peines.lourde) {
            citoyen[_addr].wallet -= 10 * 10**18;
        } else if (_peines == Peines.grave) {
            citoyen[_addr].wallet -= 100 * 10**18;
        } else if (_peines == Peines.crime) {
            citoyen[_addr].banned = true;
            citoyen[_addr].wallet = 0;
        } else revert("Invalid vote");
    }
}
