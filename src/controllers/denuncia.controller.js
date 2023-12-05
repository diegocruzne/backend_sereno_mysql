import { response } from "express";
import { pool } from "../db.js";

export const listarDenuncias = async (req, res = response) => {
  try {
    const { page, limit } = req.query;

    const pageNumber = parseInt(page) || 1;
    const limitNumber = parseInt(limit) || 10;
    const offset = (pageNumber - 1) * limitNumber;

    const [result, total] = await Promise.all([
      pool.query(
        `
        SELECT id_denuncia, DATE(fecha) AS fecha, DATE_FORMAT(fecha, '%H:%i') AS hora, delito.delito AS delito, persona.dni
        FROM denuncia 
        INNER JOIN delito ON denuncia.delito_fk = delito.id_delito
        LEFT JOIN persona ON denuncia.denunciante_fk = persona.id_persona
        ORDER BY id_denuncia DESC
        LIMIT ?, ?;`,
        [offset, limitNumber]
      ),
      pool.query(`SELECT COUNT(*) AS total FROM denuncia;`),
    ]);

    res.json({
      total: total[0][0].total,
      denuncias: result[0],
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Hubo un error",
    });
  }
};

export const buscarDenunciasPorFecha = async (req, res = response) => {
  try {
    const { date } = req.query;

    const [result, total] = await Promise.all([
      pool.query(
        `
      SELECT id_denuncia, DATE(fecha) AS fecha, DATE_FORMAT(fecha, '%H:%i') AS hora, delito.delito AS delito, persona.dni
      FROM denuncia 
      INNER JOIN delito ON denuncia.delito_fk = delito.id_delito
      LEFT JOIN persona ON denuncia.denunciante_fk = persona.id_persona
      WHERE DATE_FORMAT(fecha, '%d-%m-%y') = ?
      ORDER BY id_denuncia DESC;`,
        [date]
      ),
      pool.query(
        `SELECT COUNT(*) AS total FROM denuncia WHERE DATE_FORMAT(fecha, '%d-%m-%y') = ?;`,
        [date]
      ),
    ]);

    res.json({
      total: total[0][0].total,
      denuncias: result[0],
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Hubo un error",
    });
  }
};

export const registrarDenuncia = async ({ body }, res = response) => {
  try {
    const {
      detalles,
      direccion,
      lat,
      lng,
      delito,
      usuario,
      fecha,
      denunciante,
      patrullaje,
    } = body;

    const [result] = await pool.query(
      `INSERT INTO denuncia (detalles, direccion, coordenadas, fecha, delito_fk, denunciante_fk, usuario_fk, patrullaje_fk)
        VALUES
        (?, ?, POINT(?, ?), ?, ?, ?, ?, ?);`,
      [
        detalles,
        direccion,
        lat,
        lng,
        fecha || new Date(),
        delito,
        denunciante || null,
        usuario,
        patrullaje || null,
      ]
    );

    if (result.affectedRows === 1) {
      res.json({
        ok: true,
        msg: "Denuncia registrada!",
        id: result.insertId,
      });
    } else {
      throw new Error("Ocurrió un error");
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Hubo un error",
    });
  }
};
