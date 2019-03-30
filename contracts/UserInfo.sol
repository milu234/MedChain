pragma solidity ^0.5.0;

contract UserInfo {

	enum userType{
		Manufacturer,
		WholeSale_Dealer,
		Pharmasists,
		Admin,
		Transporter
	}
	//Model an order
	struct User {
		address accountId;
		bytes32 name;
		bytes32 email;
		bytes32 contactNumber;
		bytes32 licenseid;
		userType utype;
	}

	//storing number of users
	uint public userCount;
	address public admin;
	bytes32 admin_license;
	
	//Store the users in the system
	mapping(uint=> User ) public userslist;
	//map for userindex to account address
	mapping(address=>uint) public userMap;

	constructor() public {
		admin = msg.sender;
		admin_license = " ";
		userMap[msg.sender] = 1; 
		userslist[1].accountId = msg.sender;
		userslist[1].name = 'Admin';
		userslist[1].email = 'admin@.dasdha';
		userslist[1].contactNumber = '78954624612';
		userslist[1].licenseid = '465as46das1d621';
		userslist[1].utype = userType.Admin;
		userCount = 1;
	}

	modifier onlyAdmin{ 
		require (msg.sender == admin); 
		_; 
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
	

	function addUser(address account,string memory uname,string memory uemail,string memory ucontactNumber, string memory ulicenseid, userType utype) public onlyAdmin{
        bytes32 name = stringToBytes32(uname);
        bytes32 email = stringToBytes32(uemail);
        bytes32 contactNumber = stringToBytes32(ucontactNumber);
        bytes32 licenseid = stringToBytes32(ulicenseid);
        userslist[++userCount] = User(account, name, email, contactNumber, licenseid, utype);
        userMap[account] = userCount;
	}

	function getValue(uint _index)public returns (uint){
      return uint(userslist[_index].utype);
  }

}

