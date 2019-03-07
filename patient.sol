pragma solidity ^0.4.25;

import "./ownable.sol";

contract Patient is Ownable {

  //Events to make sure that nodes on the blockchain can be notified when a new patient is created or when a file search is successful 
  event NewPatientFile(string _hash, uint256 timeStamp, address Patient );
  event FoundPatientFile(string _hash, uint256 timeStamp, address Patient);

  //The attributes that a patient will have 
  struct PatientFile {
    string hash;
    uint256 timeStamp;
    address patient;
  }

  // This will hold an array of patients
  PatientFile[] public patientFiles;

  //A patient is mapped to the ids of all the files that she/he has 
  //This makes it easy to get all the files of a patients while only having his/her address
  mapping (address => uint[]) public patientToFiles;
  mapping (address => uint) patientOwnedFileCount;


  // A function that enables the creation of a file. 
  function _createPatientFile(string _hash, uint256 _timeStamp, address _patient) internal {
    uint id = patientFiles.push(PatientFile(_hash, _timeStamp, _patient)) - 1;
    patientToFiles[msg.sender].push(id);
    patientOwnedFileCount[msg.sender] = patientOwnedFileCount[msg.sender]+1;
    // notifiying applications that a new patient has been created
    emit NewPatientFile(_hash, _timeStamp, _patient);
  }
  
  //Emitting all the files so that they can be seen by the hospital
  function _getAllPatientFiles(address addr) external  {
  //function getAllPatientFiles(address addr) external  view return (uint232) {
       uint[] memory thepatientsFilesIds = patientToFiles[addr];
       //Loop through searched files and notify nodes on the network of found files. 
       for (uint i=0; i<thepatientsFilesIds.length; i++) {
          emit FoundPatientFile(patientFiles[thepatientsFilesIds[i]].hash, patientFiles[thepatientsFilesIds[i]].timeStamp, patientFiles[thepatientsFilesIds[i]].patient);
       }
  }
  
}
