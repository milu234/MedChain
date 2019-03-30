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
        $.getJSON("UserInfo.json", function (i) {
            //Instantiate a new truffle contract from the artifact
            Stack.contracts.UserInfo = TruffleContract(i);
            //connect provider to interact with contract
            Stack.contracts.UserInfo.setProvider(Stack.web3Provider);
        });

        Stack.contracts.UserInfo.deployed()
            .then(function (instance) {
                UserInfoInstance = instance;
                return UserInfoInstance.userCount();
            })
            .then(function (count) {
                var candidatesResults = $("#select");
            candidatesResults.empty();
                for (var i = 1; i <= count; i++) {
                    UserInfoInstance.userslist(i).then(function (candidate) {
                        var type = candidate[5];
                        if(type==0){
                              var dropdown = document.getElementById("select");
                            var dropdown = document.getElementById("select");
                            var opt = document.createElement("option");
                            opt.text = web3.toAscii(candidate[1].toString());
                            opt.value = candidate[0].toString();
                            dropdown.options.add(opt);
                        }
                    });
                }
            });
    },
    addmedicines: function (e, Name, Price){
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
        $.getJSON("Medicines.json", function(i) {
          //Instantiate a new truffle contract from the artifact
            Stack.contracts.Medicines = TruffleContract(i);
          //connect provider to interact with contract
            Stack.contracts.Medicines.setProvider(Stack.web3Provider);
        });

        Stack.contracts.Medicines.deployed().then(function(instance) {
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
    Stack.addmedicines(e,Name,Price);
}