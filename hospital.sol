pragma solidity ^0.4.25;

import "./ownable.sol";
import "./patient.sol";


//The hospital contract
contract Hospital is Ownable {

  // Emmiting events to notify nodes that a new hospital has joined the network 
  // We also notify nodes that a patient has been created 
  event NewHospital(uint HospitalId, string name, uint busCertId);
  event NewPatient(address addr, uint numberOfFiles);

  //Characteristics of an hospital 
  struct hospital {
    string name;
    address addr;
    uint32 busCertId;
  }
  
  //A hospital should be able to check if it has access to a particular person's files
  // The patient can get any file and give it to the hospital whenever needed
  struct Patient {
    address addr;
    uint numberOfFiles;
  }
  
  
  
  //An array of all patients on the blockchain
  Patient[] public patients;

 //Given an address of an hospital, a hospital should know the address of the patients that it has 
  mapping (address => address[]) public hospitalPatients;
  //A patient should also know the number of files that he/she has
  mapping (address => uint) patientOwnedFileCount;

//The hospital can create a patient
  function _createPatient(address addr, address hosp) internal {
    uint id = patients.push(Patient(addr, patientOwnedFileCount[msg.sender])) - 1;
    
    emit NewPatient(addr, patientOwnedFileCount[msg.sender]);
  }
  
}
