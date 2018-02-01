pragma solidity ^0.4.0;

contract Votacao {
    int t_votos;

    struct Candidato {
        address addr;
        string nome;
        Partido partido;
        int numero;
        int votos;
    }
    struct Partido {
        address addr;
        string nome;
        int numero;
    }
    struct Pessoa {
        address addr;
        string nome;
        int idade;
        Candidato voto;
    }
    
    mapping(address => Partido) partidos;
    mapping(address => Candidato) candidatos;
    mapping(address => Pessoa) pessoas;
    address[] _partidos;
    address[] _candidatos;
    address[] _pessoas;
    
    function Votacao () {
        t_votos = 0;
    }
    
    function InserirPartido (address partido, string nome, int numero) {
        partidos[partido].addr = partido;
        partidos[partido].nome = nome;
        partidos[partido].numero = numero;
        _partidos.push(partido);
    }
    
    function InserirCandidato (address candidato, string nome, int numero, address partido) {
        candidatos[candidato].addr = candidato;
        candidatos[candidato].nome = nome;
        candidatos[candidato].numero = numero;
        candidatos[candidato].votos = 0;
        Partido part = partidos[partido];
        candidatos[candidato].partido = part;
        _candidatos.push(candidato);
    }
    
    function Votar(address candidato) {
        candidatos[candidato].votos += 1;
        t_votos++;
    }
    
    
    function getCandidatos() returns (address[]) {
        return _candidatos;
    }
    
    function ContarVotos (address candidato) returns(int) {
        return candidatos[candidato].votos;
    }
} 
