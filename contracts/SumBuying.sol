// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Base contract for simple crowdsales
contract Crowdsale {
    event PaymentReceived(address from, uint256 amount);
    uint256 beginDate;
    uint256 endDate;
    uint256 minPayment;
    address payable destAddress;
    uint256 currSum;
    uint256 totalSum;
    uint256 productID;
    mapping(address => uint256) participantsList;

    modifier checkEndDate() {
        uint256 currDate = block.timestamp;
        require(currDate <= endDate);
        _;
    }
    modifier checkMinPayment() {
        require(msg.value >= minPayment);
        _;
    }

    constructor(
        uint256 endDate_,
        uint256 minPayment_,
        uint256 totalSum_,
        address payable destAddress_,
        uint256 productID_
    ) {
        beginDate = beginDate;
        beginDate = block.timestamp;
        endDate = endDate_;
        minPayment = minPayment_;
        currSum = 0;
        totalSum = totalSum_;
        destAddress = destAddress_;
        productID = productID_;
    }

    /**
     * @dev Getter for the current total donated sum
     */
    function getCurrSum() public view returns (uint256) {
        return currSum;
    }

    /**
     * @dev Getter for the total required sum
     */
    function getNeededSum() public view returns (uint256) {
        return totalSum;
    }

    /**
     * @dev Getter for the end date of collecting etherium
     */
    function getEndedDate() public view returns (uint256) {
        return endDate;
    }

    //todo memory and default varables
    receive() external payable checkEndDate checkMinPayment {
        //todo првоерить что больше 0, safeMath юзать
        totalSum += msg.value;
        participantsList[msg.sender] += msg.value;
        emit PaymentReceived(msg.sender, msg.value);
    }
}
