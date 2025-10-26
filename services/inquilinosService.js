const db = require('../config/db');

async function getByDepartamento(id) {
  const query = "SELECT CONCAT(i.nombres, ' ', i.ap_paterno) AS inquilino FROM inquilinos i  INNER JOIN alquileres a ON a.inquilino_id = i.id WHERE a.departamento_id  = ? ORDER BY a.id DESC LIMIT 1";
  const [inquilino] = await db.query(query, [id]);
  return inquilino[0];
}

module.exports = {
  getByDepartamento
}