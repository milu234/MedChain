pragma solidity ^0.5.0;

contract OrderProcess {

    uint public orderid;
    uint public publicCartonCount;
    uint public ordercount;
    uint public manId;

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

    function companydispatch(uint _companyid,uint _warehouseid,uint _cartoncount)private{
        orderid++;
        Order storage orderVariable = accessorder[orderid];
        orderVariable.companyid = _companyid;
        orderVariable.warehouseid = _warehouseid;
        orderVariable.cartoncount = _cartoncount;
        orderVariable.orderid = orderid;
        orderVariable.cartonInLedger = 0;
        orderVariable.status = orderStatus.OrderAccepted;
    }

    function addCarton(bytes32 _barcodehash,uint _orderid,uint _accepted,uint _medicineid,uint _medicinecount,bytes32  _batchno,bytes32  _manudate,bytes32  _expirydate)private{
        publicCartonCount++;
        Order storage orderVariable = accessorder[_orderid];
        Carton storage cartonVariable = cartonorder[publicCartonCount];

        uint cartonInLedger = orderVariable.cartonInLedger;
        uint current_total_carton_count = orderVariable.cartoncount;        

        if(current_total_carton_count >= cartonInLedger){
            cartonVariable.barcode = _barcodehash;
            cartonVariable.orderid = _orderid;
            cartonVariable.accepted = _accepted;
            cartonVariable.medicineid = _medicineid;
            cartonVariable.medicinecount = _medicinecount;
            cartonVariable.batchno = _batchno;
            cartonVariable.manudate = _manudate;
            cartonVariable.expirydate = _expirydate;
            cartonVariable.accepted = _accepted;
            orderVariable.cartonInLedger = orderVariable.cartonInLedger+1;
        }

    }

}