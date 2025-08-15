pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract ARVRModuleController {
    struct ARVRModule {
        address owner;
        string moduleName;
        uint256 moduleId;
        uint256[] sensorData;
    }

    mapping (uint256 => ARVRModule) public arvrModules;
    uint256 public moduleIdCounter;

    constructor() public {
        moduleIdCounter = 0;
    }

    function createARVRModule(string memory _moduleName) public {
        moduleIdCounter++;
        arvrModules[moduleIdCounter] = ARVRModule(msg.sender, _moduleName, moduleIdCounter, new uint256[](0));
    }

    function addSensorData(uint256 _moduleId, uint256 _sensorData) public {
        require(arvrModules[_moduleId].owner == msg.sender, "Only the owner can add sensor data");
        arvrModules[_moduleId].sensorData.push(_sensorData);
    }

    function getSensorData(uint256 _moduleId) public view returns (uint256[] memory) {
        return arvrModules[_moduleId].sensorData;
    }

    function testARVRModule() public {
        // Test case
        createARVRModule("Test Module");
        addSensorData(moduleIdCounter, 10);
        addSensorData(moduleIdCounter, 20);
        uint256[] memory sensorData = getSensorData(moduleIdCounter);
        require(sensorData.length == 2, "Sensor data length should be 2");
        require(sensorData[0] == 10, "Sensor data should be 10");
        require(sensorData[1] == 20, "Sensor data should be 20");
    }
}