pragma solidity ^0.4.0;


contract Sala {
    string nome_prof;
    uint256 public saldo;
    Diretor public diretor;

    struct Diretor {
        address addr;
        string nome;
    }

    struct Professor {
        address addr;
        string nome;
        uint salario;
    }
    
    struct Aluno {
        address addr;
        string nome;
        int precensas;
    }
    
    modifier onlyDiretor() {
        require(diretor.addr == msg.sender);
        _;
    }
    modifier onlyDiretorOrProfessor () {
        require(diretor.addr == msg.sender || professor[nome_prof].addr == msg.sender);
        _;
    }
    modifier onlyProfessorOrAluno () {
        require(professor[nome_prof].addr == msg.sender || alunos[msg.sender].addr == msg.sender);
        _;
    }

    mapping(string => Professor) professor;
    mapping(address => Aluno) alunos;
    
    Aluno[] public _alunos;
    
    function Sala(string nome) payable {
        diretor.nome = nome;
        diretor.addr = msg.sender;
        saldo = msg.value;
    }
    
    function getDiretor () returns (string) {
        return diretor.nome;
    }
    
    function getProfessor () returns (string) {
        return professor[nome_prof].nome;
    }

    function getSalario () returns (uint256) {
        return professor[nome_prof].salario;
    }

    function getAlunos () returns (Aluno[]) {
        return _alunos;
    }

    function getPrecensas (address addr) onlyProfessorOrAluno returns (int){
        if(alunos[msg.sender].addr == addr) {
            return alunos[msg.sender].precensas;
        } else {
            return alunos[addr].precensas;
        }
    }
    
    function depositar () onlyDiretor {
        saldo += msg.value;
    }
    
    function setProfessor (string nome, uint256 salario, address addr) onlyDiretor returns(string){
        professor[nome].nome = nome;
        professor[nome].addr = addr;
        professor[nome].salario = salario;
        nome_prof = nome;
        return professor[nome].nome;
    }
    
    function setAluno (string nome, address addr) onlyDiretorOrProfessor {
        alunos[addr].addr = addr;
        alunos[addr].nome = nome;
        alunos[addr].precensas = 0;
        _alunos.push(alunos[addr]);
    }
    
    function registrarPrecensa (address addr) onlyProfessorOrAluno {
        alunos[addr].precensas += 1;
    }
    
    function pagarProfessor () onlyDiretor payable returns (bool) {
        if(saldo >= professor[nome_prof].salario) {
            saldo -= professor[nome_prof].salario;
            professor[nome_prof].addr.transfer(professor[nome_prof].salario);
        }
        
        return (saldo >= professor[nome_prof].salario);
    }
} 
