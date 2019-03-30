pragma solidity ^0.5.0;

contract Medicines{

	//structure of branded medicines
	struct brandMedicine{
		uint ManId;
		bytes32 brandName;
		uint price;
	}

	uint public brandMedCount;
	address admin;

	modifier onlyAdmin{ 
		require (msg.sender == admin); 
		_; 
	}

	mapping(uint=>brandMedicine) public brandMedList;

	constructor() public {
		admin = msg.sender;
	}


	function getBrandMedId(bytes32 name) public returns (uint){
		if(brandMedCount==0) return 0;
		else{
			uint i = 1;
			while(i!=brandMedCount){
				brandMedicine storage obj = brandMedList[i];
				if(obj.brandName==name) return i;
				i++;
			}
		}
		return 0;
	}

	function stringToBytes32(string memory source) public returns (bytes32 result) {
	    bytes memory tempEmptyStringTest = bytes(source);
	    if (tempEmptyStringTest.length == 0) {
	        return 0x0;
	    }

	    assembly {
	        result := mload(add(source, 32))
	    }
	}


	function addMedicines(uint manId, string memory brandName, uint price) public onlyAdmin{
		bytes32 bName = stringToBytes32(brandName);
		uint indexMed = getBrandMedId(bName);
		if(indexMed==0){
			brandMedList[++brandMedCount] = brandMedicine(manId,bName,price);
		}
	}


	// function viewMeds(uint manId) public returns (uint){
	// 	uint i;
	// 	bytes32[] public brandMedArr;
	// 	while(i!=brandMedCount){
	// 		if(manId=brandMedList[i].manId){
	// 			brandMedArr[i] = brandMedList[i++].brandName;
	// 		}
	// 	}
	// 	return i;
	// }

}