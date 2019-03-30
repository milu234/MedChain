pragma solidity ^0.5.0;

contract OrderWholesaler{
	
	// enum status{
	// 	pending,
	// 	accepted,
	// 	rejected
	// }

	uint orderCount;
	uint distinctOrders;
	uint defManId;

	//struct of order placed by wholesaler
	struct Order{
		uint orderId;
		uint medId;
		uint count;
		uint manId;
		uint status;
	}

	mapping(uint=>Order) public orderMap;
	Order public obj;

	//initialize order object
	function startOrder(uint manId) public {
		++distinctOrders;
	}

	//complete and place order
	function placeOrder(uint manId) public{
		obj.manId = manId;
		orderMap[++orderCount] = obj;
	}

	//append medicines to list
	function addMedToOrder(uint medId, uint count,uint manId) public {
		uint orderId = distinctOrders;
		obj = Order(orderId,medId,count,manId,0);
		orderMap[++orderCount] = obj;
	}

	function acceptOrder(uint orderId) public{
		require(orderId<=distinctOrders);
		for(uint i=0;i<orderCount;i++){
			if(orderMap[i].status == 0){
				if(orderMap[i].orderId == orderId){
					orderMap[i].status = uint(1);
				}
			}
			
		}
	}

	function rejectOrder(uint orderId) public{
		require(orderId<=distinctOrders);
		for(uint i=0;i<orderCount;i++){
			if(orderMap[i].status == 0){
				if(orderMap[i].orderId == orderId){
					orderMap[i].status = uint(2);
				}
			}
		}
	}

}