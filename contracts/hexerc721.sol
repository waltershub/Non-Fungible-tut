pragma solidity ^0.4.17;

import "github.com/Arachnid/solidity-stringutils/strings.sol";
import "https://github.com/pipermerriam/ethereum-string-utils/blob/master/contracts/StringLib.sol"

contract HexColorToken {

    uint256 private totalSupply = 999999;
    mapping(address => uint) private balances;
    mapping(uint256 => address) private tokenOwners;
    mapping(uint256 => bool) private tokenExists;
    mapping(address => mapping (address => uint256)) allowed;
    mapping(address => mapping(uint256 => uint256)) private ownerTokens;
    // not sure about those
    mapping(uint256 => string) tokenLinks;

    function name() public constant returns (string name){
        return "Hex Color Token";
    }

    function symbol() public constant returns (string symbol){
        return "HCT";
    }

    function getTotalSupply() public constant returns (uint256 supply){
        return totalSupply;
    }

    function balanceOf(address _owner) public constant returns (uint balance)
    {
        return balances[_owner];
    }

    function ownerOf(uint256 _tokenId) public constant returns (address owner) {
        require(tokenExists[_tokenId]);
        return tokenOwners[_tokenId];
    }

    function approve(address _to, uint256 _tokenId){
      require(msg.sender == ownerOf(_tokenId));
      require(msg.sender != _to);
      allowed[msg.sender][_to] = _tokenId;
      Approval(msg.sender, _to, _tokenId);
    }

    function takeOwnership(uint256 _tokenId){
        require(tokenExists[_tokenId]);
        address oldOwner = ownerOf(_tokenId);
        address newOwner = msg.sender;
        require(newOwner != oldOwner);
        require(allowed[oldOwner][newOwner] == _tokenId);
        balances[oldOwner] -= 1;
        tokenOwners[_tokenId] = newOwner;
        balances[newOwner] += 1;
        Transfer(oldOwner, newOwner, _tokenId);
    }
    // unclear what the for loop does here
  function removeFromTokenList(address owner, uint256 _tokenId) private {

        for (uint256 i = 0;ownerTokens[owner][i] != _tokenId;i++){
            ownerTokens[owner][i] = 0;
        }
 }
    function transfer(address _to, uint256 _tokenId) public {

        address currentOwner = msg.sender;
        address newOwner = _to;
        require(tokenExists[_tokenId]);
        require(currentOwner == ownerOf(_tokenId));
        require(currentOwner != newOwner);
        require(newOwner != address(0));
        removeFromTokenList(_tokenId);
        balances[oldOwner] -= 1;
        tokenOwners[_tokenId] = newOwner;
        balances[newOwner] += 1;
        Transfer(oldOwner, newOwner, _tokenId);
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index)  public constant returns (uint tokenId){
        return ownerTokens[_owner][_index];
    }

    function tokenMetadata(uint256 _tokenId) public constant returns (string infoUrl) {
        string token = stringUtils.uintToBytes(_tokenId)
        string end = 'HCT*'
        string beginning = 'http://large-type.com/#*1HCT*'
        string endUrl = token.toSlice().concat(end.toSlice());
        string uniqUrl = beginning.toSlice().concat(endUrl.toSlice());

        return uniqUrl

    }

}
