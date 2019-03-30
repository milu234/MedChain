(Stack = {
    web3Provider: null,
    contracts: {},
    account: "0x0",
    render: function() {
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
      $.getJSON("UserInfo.json", function(i) {
        //Instantiate a new truffle contract from the artifact
        Stack.contracts.UserInfo = TruffleContract(i);
        //connect provider to interact with contract
        Stack.contracts.UserInfo.setProvider(Stack.web3Provider);
      });
      
      Stack.contracts.UserInfo.deployed()
        .then(function(instance) {
          UserInfoInstance = instance;
          return UserInfoInstance.userCount();
        })
        .then(function(count) {
              // var candidatesResults = $("#select");
              // candidatesResults.empty();
              // count = count.toNumber();
              // for (var i = count + 1; i <= 10; i++) {
              //   var dropdown = document.getElementById("select");
              //   var opt = document.createElement("option");
              //   opt.text = i;
              //   opt.value = i;
              //   dropdown.options.add(opt);
              // }
        });
    },
  
  
  
    
      addstackholder: function (address, Name, Email, Contact, License, number){
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
  
        Stack.contracts.UserInfo.deployed().then(function (instance) {
            ins = instance;
            ins.addUser(address, Name, Email, Contact, License, number);
            console.log(111)
        })
                
    },
  }),
  
  
  
  
    $(window).on("load", function() {
      Stack.render();
    });
  
  
  $("form").submit(function (event) {
      event.preventDefault();
      var address = $("#ad").val();
      var Name = $("#Name").val();
      var Email = $("#Email").val();
      var License = $("#License").val();
      var Contact = $("#Contact").val();
      var Role = $("#Role").val();
      var number = 0;
      if (Role === "Manufacturer") {
        number = 0;
      } else if (Role == "Wholesale Dealer") {
        number = 1;
      } else if (Role == "Pharmasists") {
        number = 2;
      } else if (Role == "Admin") {
        number = 3;
      } else if (Role == "Transporter") {
        number = 4;
      }
      // Stack.contracts.UserInfo.addUser(address, Name, Email, Contact, License, number);
      Stack.addstackholder(address, Name, Email, Contact, License, number);
  });
  