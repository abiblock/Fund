// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 < 0.9.0;

import"@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//import"@chainlink/contract/src/v0.6/vendor/SafeMatchChainlink.sol";
contract FundMe{

  //  using SafeMatchChainlink for uint256;
    mapping(address=>uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
        constructor () public {
        owner=msg.sender;
    }
    function fund() public payable{
        //setting the minimum amount to $50
        uint256 minimumUSD = 5 * 10 ** 8;
        require(msg.value >= minimumUSD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    modifier onlyOwner{
        //_; before running this modefier, do others
        require(msg.sender==owner);
        _; //do this first before executing other functions
    }
    function withdraw() payable onlyOwner public {
        //require (msg.sender==owner); //we don't need this if we have modifier
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        funders=new address[](0);
    }


        //sending other currencies
        //we will use Oracles to find the current currency values
function getVersion() public view returns (uint256){
return AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).version();
}
    
}