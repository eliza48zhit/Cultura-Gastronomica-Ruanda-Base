// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaRuanda
 * @dev Registro de procesos de emulsion de hojas y gestion de almidones de altura.
 * Serie: Sabores de Africa (27/54)
 */
contract CulturaRuanda {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 densidadCacahuete;  // Porcentaje de pasta en la mezcla (1-100)
        uint256 tiempoCoccionMin;   // Minutos de coccion de las hojas (min 60)
        bool usaAceitePalma;        // Validador de emulsion de clorofila
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Isombe (Ingenieria de la clorofila)
        registrarPlato(
            "Isombe", 
            "Hojas de mandioca, berenjenas, pasta de cacahuete, aceite de palma.",
            "Triturar hojas frescas, hervir prolongadamente y emulsionar con pasta de cacahuete y vegetales.",
            30, 
            120, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _cacahuete, 
        uint256 _tiempo,
        bool _palma
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_tiempo >= 60, "Seguridad: Tiempo de coccion insuficiente para hojas de mandioca");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            densidadCacahuete: _cacahuete,
            tiempoCoccionMin: _tiempo,
            usaAceitePalma: _palma,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 cacahuete,
        uint256 tiempo,
        bool palma,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.densidadCacahuete, p.tiempoCoccionMin, p.usaAceitePalma, p.likes);
    }
}
