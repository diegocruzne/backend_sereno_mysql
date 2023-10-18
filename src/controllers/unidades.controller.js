import { response } from "express";
import { pool } from "../db.js";

export const getUnidades = async (req, res = response) => {
  try {
    const [result] = await pool.query("select * from unidad");
    res.send(result);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const getUnidadPorId = async (req, res = response) => {
  const { id } = req.params;

  const [result] = await pool.query(
    "SELECT * FROM unidad WHERE id_unidad = ?",
    [id]
  );

  res.send(result);
};

export const unidadesAvailables = async (req, res = response) => {
  // Todo: Revisar todo 'unidadesAvailables'
  const { id_turno } = req.params;

  try {
    const [result] = await pool.query(
      "SELECT unidad.id_unidad, \n " +
        "CONCAT(tipo_unidad.tipo_unidad, ' - ', unidad.placa) as unidad_list, \n " +
        "GROUP_CONCAT(patrullaje.id_patrullaje SEPARATOR ', ') AS patrullajes_pertenecientes \n " +
        "FROM unidad LEFT JOIN patrullaje ON unidad.id_unidad = patrullaje.fk_unidad \n " +
        "INNER JOIN tipo_unidad ON unidad.fk_tipo_unidad = tipo_unidad.id_tipo_unidad \n " +
        "GROUP BY unidad.id_unidad, CONCAT(tipo_unidad.tipo_unidad, ' - ', unidad.placa) \n " +
        "ORDER BY CONCAT(tipo_unidad.tipo_unidad, ' - ', unidad.placa)"
    );

    const dataFilter = result.filter((item) => {
      const patrullajes = item.patrullajes_pertenecientes;
      return !patrullajes || !patrullajes.includes(`${id_turno}`);
    });

    res.send(dataFilter);
  } catch (err) {
    console.log(err);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }
};

export const crearUnidad = async (req, res = response) => {
    const { placa, desc, estado, tipo_uni } = req.body;

    try {
      const [result] = await pool.query(
        "SELECT placa FROM unidad WHERE placa = TRIM(?)",
        [placa]
      );

      if (result[0]) {
        return res.status(400).json({
          ok: false,
          msg: "Placa ya existe",
        });
      }

      const rep = await pool.query(
        "INSERT INTO unidad (placa, descripcion, estado, fk_tipo_unidad) VALUES (?, ?, ?, ?)",
        [placa, desc, estado, tipo_uni]
      );

      res.json({
        ok: true,
        unidad: { placa, desc, estado, tipo_uni },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({
        ok: false,
        msg: "Error inesperado",
      });
    }
}

export const actualizarUnidad = async (req, res = response) => {
  const { placa, desc, estado, tipo_uni } = req.body;
  const { id } = req.params;

  try {
    const result = await pool.query(
      "UPDATE unidad SET placa = ?, descripcion = ?, estado = ?, fk_tipo_unidad = ? WHERE id_unidad = ?",
      [placa, desc, estado, tipo_uni, id]
    );

    return res.json({
      ok: true,
      unidad: { placa, desc, estado, tipo_uni, id },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Placa ya existe o error inesperado",
    });
  }
}
