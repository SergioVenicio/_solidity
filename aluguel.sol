pragma solidity ^0.4.0;

contract Aluguel {
    address public owner;
    uint256 public valor;
    uint256 public total;
    uint256 public quantidade_meses;
    
    struct Inquilino {
        string nome;
        address addr;
    }
    
    struct Locatario {
        string nome;
        address addr;
    }
    
    struct Casa {
        string rua;
        uint256 numero;
        bool alugada;
    }
    
    mapping(address => Inquilino ) inquilino;
    mapping(address => Locatario ) locatario;
    mapping(uint256 => Casa ) casa;
    
    modifier onlyInquilino () {
        require(inquilino[msg.sender].addr == msg.sender);
        _;
    }
    modifier onlyLocatario () {
        require(locatario[msg.sender].addr == msg.sender);
        _;
    }

    function Aluguel (string nome, uint256 v, string rua, uint256 n) {
        owner = msg.sender;
        locatario[msg.sender].addr = msg.sender;
        locatario[msg.sender].nome = nome;
        casa[0].rua = rua;
        casa[0].numero = n;
        casa[0].alugada = false;
        valor = v;
        total = 0;
    }
    
    function getCasa () returns (string, uint256) {
        return(casa[0].rua, casa[0].numero);
    }
    
    function Alugar (string nome) payable {
        if(valor == msg.value && !casa[0].alugada) {
            inquilino[msg.sender].nome = nome;
            inquilino[msg.sender].addr = msg.sender;
            total += msg.value;
            quantidade_meses = 1;
            casa[0].alugada = true;
            owner.transfer(msg.value);
        } else {
            msg.sender.transfer(msg.value);
            return;
        }
    }
    
    function PagarAluguel () onlyInquilino payable {
        if(inquilino[msg.sender].addr == msg.sender && msg.value == valor) {
            total += msg.value;
            quantidade_meses += 1;
            owner.transfer(msg.value);
        } else {
            msg.sender.transfer(msg.value);
            return;
        }
    }
} 
