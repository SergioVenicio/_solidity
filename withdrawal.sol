pragma solidity ^0.4.0;

contract Wallet {
    address owner;
    uint amount;
    
    struct Contribuinte {
        uint valor;
        address endereco;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    mapping(address => Contribuinte) contribuintes;

    function Wallet() payable {
        owner = msg.sender;
        amount = msg.value;
    }
    
    function GetOwner() returns(address) {
        if(msg.sender == owner || contribuintes[msg.sender].valor > 0) {
            return owner;
        } else {
            return;
        }
    }
    
    function GetBalance() returns(uint) {
        if(msg.sender == owner || contribuintes[msg.sender].valor > 0) {
            return amount;
        } else {
            return;
        }
    }
    
    function withdrawal() payable returns(bool){
        if(msg. value > 0) {
            contribuintes[msg.sender].endereco = msg.sender;
            contribuintes[msg.sender].valor = msg.value;
            amount += msg.value;
            return true;
        } else {
            return false;
        }
    }
    
    function finishAccount() onlyOwner payable returns(bool) {
        owner.transfer(amount);
        amount -= amount;
        return true;
    }
    
    function DevolverGrana() payable returns(uint) {
        if(contribuintes[msg.sender].valor >= msg.value) {
            uint extorno = contribuintes[msg.sender].valor;
            if(extorno > 0) {
                contribuintes[msg.sender].endereco.transfer(extorno);
                contribuintes[msg.sender].valor = 0;
                amount -= extorno;
            }
            return extorno;
        } else {
            return;
        }
    }
} 
