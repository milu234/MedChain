
Stack = {
    web3Provider: null,
    contracts: {},
    account: '0x0',



    render: function () {
        if (typeof web3 !== "undefined") {
            Stack.web3Provider = web3.currentProvider;
            web3 = new Web3(web3.currentProvider);
        } else {
            Stack.web3Provider = new Web3(
                new Web3.providers.HttpProvider("http://127.0.0.1:7545")
            );
            web3 = new Web3(Stack.web3Provider);
        }

        $.ajaxSetup({ async: false });
        $.getJSON("OrderProcess.json", function (i) {
            //Instantiate a new truffle contract from the artifact
            Stack.contracts.OrderProcess = TruffleContract(i);
            //connect provider to interact with contract
            Stack.contracts.OrderProcess.setProvider(Stack.web3Provider);
        });

        Stack.contracts.OrderProcess.deployed()
            .then(function (instance) {
                OrderProcessInstance = instance;
                return OrderProcessInstance.cartonInLedger();
            })
            .then(function (count) {
                var ta = $("#select");
                ta.empty();
                for (var i = 1; i <= count; i++) {
                    OrderProcessInstance.cartonorder(i).then(function (candidate) {
                        var barcode = candidate[0];
                        var orderid = candidate[1];
                        var medicineid = candidate[2];
                        var medicinecount = candidate[3];
                        var batchno = candidate[4];
                        var manudate = candidate[5];
                        var expirydate = candidate[6];
                        var accepted = candidate[7];
                        var rejectedby = candidate[8];
                        console.log(barcode)
                    });
                }
            });
    },
    addmedicines: function (e, Name, Price) {
        if (typeof web3 !== "undefined") {
            Stack.web3Provider = web3.currentProvider;
            web3 = new Web3(web3.currentProvider);
        } else {
            Stack.web3Provider = new Web3(
                new Web3.providers.HttpProvider("http://127.0.0.1:7545")
            );
            web3 = new Web3(Stack.web3Provider);
        }

        $.ajaxSetup({ async: false });
        $.getJSON("Medicines.json", function (i) {
            //Instantiate a new truffle contract from the artifact
            Stack.contracts.Medicines = TruffleContract(i);
            //connect provider to interact with contract
            Stack.contracts.Medicines.setProvider(Stack.web3Provider);
        });

        Stack.contracts.Medicines.deployed().then(function (instance) {
            MedicinesInstance = instance;
            return MedicinesInstance.addMedicines(e, Name, Price);
        });

    }


},



    $(window).on("load", function () {
        Stack.render();
    });



function extr() {
    var e = $('#select').find(":selected").val();
    var Name = $("#Name").val();
    var Price = $("#Price").val();
    Stack.addmedicines(e, Name, Price);
}