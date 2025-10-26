const service = require('../services/edificiosService');

async function getById(req, res) {
  try {
    const { id } = req.params;
    const edificio = await service.getById(id);
    res.status(200).json({
      cantDepartamentos: edificio[0],
      direccion: edificio[1],
      cantPisos: edificio[2],
      departamentos: edificio[3]
    });
  } catch (error) {
    const code = error.status || 500;
    res.status(code).json({
      success: false,
      data: error.message
    });
  }
}

module.exports = {
  getById
}

/*
async function name(req, res) {
  try {

    res.status(200).json({
      success: true,
      data: objeto
    });
  } catch (error) {
    const code = error.status || 500;
    res.status(code).json({
      success: false,
      data: error.message
    });
  }
}
*/