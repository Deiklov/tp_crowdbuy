// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/// @title Base contract for simple crowdbuy
contract CrowdBuy {
    using SafeMath for uint256;
    /**
     * Евент о получении платежа
     * @param from Адрес от кого получили
     * @param amount Количество полученного эфира
     */
    event PaymentReceived(address from, uint256 amount);
    /**
     * Евент об окончании сбора средств
     * @param productID ID покупаемого товара
     * @param totalSum Общая собранная сумма
     */
    event CrowdFinished(uint256 productID, uint256 totalSum);

    uint256 beginDate;
    uint256 endDate;
    uint256 minPayment;
    address payable destAddress;
    uint256 currSum;
    uint256 totalSum;
    uint256 productID;
    bool isFinished = false;
    mapping(address => uint256) participantsList;


    modifier checkIsFinished() {
        require(!isFinished);
        _;
    }

    modifier checkIsSeller() {
        require(!isFinished);
        _;
    }
    /**
     * @param _endDate Даты окончания покупки
     * @param _minPayment Минимальный входной платеж
     * @param _totalSum Общая сумма, которую нужно собрать
     * @param _destAddress Адрес, куда пойдут собранные деньги
     * @param _productID ID товара который собрались покупать
     */
    constructor(
        uint256 _endDate,
        uint256 _minPayment,
        uint256 _totalSum,
        address payable _destAddress,
        uint256 _productID
    ) public {
        require(_endDate > block.timestamp);
        require(_totalSum > 0);
        require(_destAddress != address(0));
        require(_minPayment > 0);

        beginDate = block.timestamp;
        endDate = _endDate;
        minPayment = _minPayment;
        currSum = 0;
        totalSum = _totalSum;
        destAddress = _destAddress;
        productID = _productID;
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
     * @dev Проверка закончились ли сборы
     */
    function getIsFinished() public view returns (bool) {
        return isFinished;
    }

    /**
     * @dev Getter for the end date of collecting etherium
     */
    function getEndedDate() public view returns (uint256) {
        return endDate;
    }
    /**
     * @dev Получение очередного платежа
     */
    receive() external payable {
        require(currSum < totalSum);
        require(block.timestamp < endDate);
        require(msg.value >= minPayment);
        require(!isFinished);

        currSum = currSum.add(msg.value);
        //никак не используется
        participantsList[msg.sender] = participantsList[msg.sender].add(msg.value);

        if (currSum >= totalSum) {
            finishCrowd();
        }
        emit PaymentReceived(msg.sender, msg.value);
    }

    function endCrowdbuy() external checkIsFinished checkIsSeller {
        require(!isFinished);
        finishCrowd();
    }

    function finishCrowd() internal {
        isFinished = true;
        destAddress.transfer(currSum);
        emit CrowdFinished(productID, currSum);
    }
}
