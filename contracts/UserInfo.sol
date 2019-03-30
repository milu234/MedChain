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
	address admin;
	bytes32 admin_license;
	
	//Store the users in the system
	mapping(uint=> User ) public userslist;
	//map for userindex to account address
	mapping(address=>uint) public userMap;

	constructor() public {
		admin = msg.sender;
		admin_license = " ";
	}

	modifier onlyAdmin{ 
		require (msg.sender == admin); 
		_; 
	}
	
	function users(bytes32 name, bytes32 email, bytes32 contactNumber) public {
        // Admin is the first user of the system at index 1
        userslist[++userCount] = User(admin, name, email, contactNumber, admin_license, userType.Admin);
        userMap[admin] = userCount;
    }

	function addUser(address account,bytes32 name,bytes32 email,bytes32 contactNumber, bytes32 licenseid, userType utype) public onlyAdmin{
        userslist[++userCount] = User(account, name, email, contactNumber, licenseid, utype);
        userMap[account] = userCount;
	}

}

