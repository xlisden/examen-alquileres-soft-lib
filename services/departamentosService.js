const db = require('../config/db');
const inquilinoService = require('./inquilinosService');
const Departamento = require('../models/Departamento');

async function getByEdificio(id) {
  const [rows] = await db.query("SELECT * FROM departamentos WHERE edificio_id = ?", [id]);  
  const departamentos = [];

  for (let i = 0; i < rows.length; i++) {
    const inquilino = await inquilinoService.getByDepartamento(rows[i].id);
    const departamento = {
      nro: rows[i].nro,
      piso: rows[i].piso,
      area: rows[i].area,
      nro_habitaciones: rows[i].nro_habitaciones,
    };  
    if (inquilino && inquilino.inquilino) {
      departamento.inquilino = inquilino.inquilino;
    }

    departamentos.push(departamento);
  }

  return departamentos;
}

module.exports = {
  getByEdificio
}