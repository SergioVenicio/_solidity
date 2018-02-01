pragma solidity ^0.4.0;

contract Venda {
    address public vendedor;
    uint256 saldo;

    struct Produto {
        string descricao;
        uint256 valor;
        uint256 qntd;
    }
    
    mapping(string => Produto) produto;

    modifier onlyVendedor () {
        require(msg.sender == vendedor);
        _;
    }
    
    function Venda (string desc, uint256 val, uint256 qntd) {
        if(val > 0 && qntd > 0) {
            vendedor = msg.sender;
            produto[desc].descricao = desc;
            produto[desc].valor = val;
            produto[desc].qntd = qntd;
        }
        return;
    }
    
    function Comprar (string desc, uint256 qntd) payable {
        if(msg.sender != vendedor) {
            if(qntd <= produto[desc].qntd && msg.value == (produto[desc].valor * qntd)) {
                produto[desc].qntd -= qntd;
                saldo += (msg.value);
            } else {
                msg.sender.transfer(msg.value);
            }
        }
        return;
    }
    
    
    function getSaldo () onlyVendedor returns(uint256){
        return saldo;
    }
    
    
    function getPreco (string desc) returns(uint256) {
        return produto[desc].valor;
    }

    function getQuantidade (string desc) returns(uint256) {
        return produto[desc].qntd;
    }
    
    function Receber () onlyVendedor payable{
        if(saldo > 0) {
            vendedor.transfer(saldo);
            saldo -= saldo;
        }
    }
} 
