App = {
    web3Provider: null,
    contracts: {},
    account: '0x0',

    init: async function () {

        return await App.initWeb3();
    },

    initWeb3: function () {
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
            web3 = new Web3(web3.currentProvider);
        }
        else {
            App.web3Provider = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
            web3 = new Web3(App.web3Provider);
        }
        return App.initContract();
    },

    initContract: function () {
        $.ajaxSetup({ async: false });
        // $.getJSON('Manware.json', function (i) {
        //     App.contracts.Manware = TruffleContract(i);
        //     App.contracts.Manware.setProvider(App.web3Provider);
        // });
        return App.login();
    },
    login: function(){
        web3.eth.getAccounts(function (err, accounts) {
            if (err != null) console.error("An error occurred: " + err);
            else if (accounts.length == 0){
                document.getElementById("loginbutton").disabled = true;
                alert("Please Login to MetaMask");
            } 
            else{
                //GET ACCOUNT ADDRESS
                  web3.eth.getCoinbase(function(err, account) {
                    if (err === null) {
                      App.account = account;
                        window.alert("Logged In MetaMask");
                    } else {
                      window.alert("Please Login In MetaMask");
                      window.location.href = "localhost:3000";
                    }
                  });

                //CREAte Contract connection and redirect
                $.ajaxSetup({ async: false });
                $.getJSON('UserInfo.json', function (i) {
                    App.contracts.UserInfo = TruffleContract(i);
                    App.contracts.UserInfo.setProvider(App.web3Provider);
                });
                


                }
        });
    },


    redirect: function () {
        App.contracts.UserInfo.deployed().then(function (instance) {
            UserInfoInstance = instance;
            console.log(App.account);   
            return UserInfoInstance.userMap(App.account);
            
        }).then(function (index) {
            console.log(index.toNumber());   
            return UserInfoInstance.userslist(index.toNumber());
            
        }).then(function(data){
            console.log(data[5].toNumber());
            if (data[5].toNumber() == 3) {
                window.location.href = "admin-panel.html";
            }
            else if (data[5].toNumber() == 0) {
                window.location.href = "wholesale-neworder.html";
            }
        })

    },
    
    

},



    $(function () {
        $(window).load(function () {
            App.init();
        });
    });