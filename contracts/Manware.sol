pragma solidity ^0.5.0;

contract Manware {


    uint public orderid=0;
    uint public publicCartonCount=0;

    enum orderStatus{
		OrderPlaced,
		OrderAccepted,
		OrderRejected,
		OrderDispatched,
        FullOrderAccepted,
        PartialOrderAccepted,
        Rejected
    }


    struct Carton{
        bytes32 barcode;
        uint orderid;
        bytes32 EPC;
        uint medicineid;
        uint medicinecount;
        bytes32 batchno;
        bytes32 manudate;
        bytes32 expirydate;
        uint accepted;
        bytes32 rejectedby;
    }
    struct Order{
        uint cartonInLedger;
        uint companyid;
        uint warehouseid;
        uint cartoncount;
        uint orderid;
        orderStatus status;
    }
    mapping(uint =>Carton) public cartonorder;
    mapping(uint =>Order) public accessorder;

    uint public ordercount;
    constructor() public{
        companydispatch(1,1,2);
        addCarton("x1s5f0s6asd0a36sd03ase43asd034",1,100,"1x054670",512,100,"23-5689","28-03-2019","28-03-2022");
        addCarton("x1s5f0s6asd0a36sd03ase43asd035",1,500,"1x054670",512,100,"23-5689","28-03-2019","28-03-2022");
        // changeAccepted(1,"x1s5f0s6asd0a36sd03ase43asd035",50,1);
        changeAccepted();
    }
    
    function companydispatch(uint _companyid,uint _warehouseid,uint _cartoncount)private{
        orderid++;
        Manware.Order storage orderVariable = accessorder[orderid];
        orderVariable.companyid = _companyid;
        orderVariable.warehouseid = _warehouseid;
        orderVariable.cartoncount = _cartoncount;
        orderVariable.orderid = orderid;
        orderVariable.cartonInLedger = 0;
        orderVariable.status = orderStatus.OrderAccepted;
    }
    function addCarton(bytes32 _barcodehash,uint _orderid,uint _accepted,bytes32 _EPC,uint _medicineid,uint _medicinecount,bytes32  _batchno,bytes32  _manudate,bytes32  _expirydate)private{
        publicCartonCount++;
        Manware.Order storage orderVariable = accessorder[_orderid];
        Manware.Carton storage cartonVariable = cartonorder[publicCartonCount];

        uint cartonInLedger = orderVariable.cartonInLedger;
        uint current_total_carton_count = orderVariable.cartoncount;        

        if(current_total_carton_count >= cartonInLedger){
            cartonVariable.barcode = _barcodehash;
            cartonVariable.orderid = _orderid;
            cartonVariable.accepted = _accepted;
            cartonVariable.EPC = _EPC;
            cartonVariable.medicineid = _medicineid;
            cartonVariable.medicinecount = _medicinecount;
            cartonVariable.batchno = _batchno;
            cartonVariable.manudate = _manudate;
            cartonVariable.expirydate = _expirydate;
            cartonVariable.accepted = _accepted;
            orderVariable.cartonInLedger = orderVariable.cartonInLedger+1;
        }

    }

    function acceptOrder(uint _orderid)private{

        if(_orderid <= orderid){
            Manware.Order storage orderVariable = accessorder[_orderid];
            orderVariable.status = orderStatus.OrderAccepted;
        }
    }

    function rejectOrder(uint _orderid)private{
        if(_orderid == orderid){
            Manware.Order storage orderVariable = accessorder[_orderid];
            orderVariable.status = orderStatus.OrderRejected;
        }
    }
    
// Manware.deployed().then(function(i){app=i})
// app.cartonorder(2).then(function(i){two=i})
// app.cartonorder(1).then(function(i){one=i})

    function changeAccepted() public{
        cartonorder[1].accepted = 50;
        cartonorder[1].barcode = "lol";
    }

}