const db = require('../config/db');
const departamentosService = require('./departamentosService');

async function getById(id) {
  const [ edificio ] = await db.query("SELECT DISTINCT * FROM edificios WHERE id = ?", [id]);
  const departamentos = await departamentosService.getByEdificio(id);
  return [edificio[0].nro_departamentos, edificio[0].direccion, edificio[0].nro_pisos, departamentos];
}

module.exports = {
  getById
}