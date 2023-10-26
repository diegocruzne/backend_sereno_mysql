import { response } from "express";
import { pool } from "../db.js";

export const newPatrullaje = async (req, res = response) => {
  const { desc, turno, unidad } = req.body;

  try {
    // Verificar si la unidad ya está asignada a un turno
    const [available] = await pool.query(
      "SELECT * FROM patrullaje WHERE fk_turno = ? AND fk_unidad = ?",
      [turno, unidad]
    );

    if (available.length >= 1) {
      return res.status(400).json({
        ok: false,
        msg: "Unidad no disponible en este turno",
      });
    }

    const [result] = await pool.query(
      "INSERT INTO patrullaje (descripcion, fk_turno, fk_unidad) VALUES (?, ?, ?)",
      [desc, turno, unidad]
    );

    res.json({
      ok: true,
      msg: "Patrullaje creado!",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Placa ya existe o error inesperado",
    });
  }
};

export const getPatrullajePorId = async (req, res = response) => {
  const { id } = req.params;

  try {
    const [result] = await pool.query(
      "SELECT id_patrullaje, patrullaje.descripcion, turno.turno, unidad.placa, tipo_unidad.tipo_unidad, \n " +
        "CASE \n " +
        "WHEN patrullaje.estado = 1 THEN 'Activo' \n " +
        "WHEN patrullaje.estado = 0 THEN 'Inactivo' \n " +
        "END AS estado \n " +
        "FROM patrullaje INNER JOIN turno ON patrullaje.fk_turno = turno.id_turno \n " +
        "INNER JOIN unidad ON patrullaje.fk_unidad = unidad.id_unidad \n " +
        "INNER JOIN tipo_unidad ON unidad.fk_tipo_unidad = tipo_unidad.id_tipo_unidad \n " +
        "WHERE id_patrullaje = ?",
      [id]
    );

    res.send(result[0]);
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Hubo un error",
    });
  }
};

export const getPatrullajes_detalles = async (req, res = response) => {
  try {
    const [result] = await pool.query(
      "SELECT patrullaje.id_patrullaje, patrullaje.descripcion, turno.turno, tipo_unidad.tipo_unidad, unidad.placa,  \n " +
        "fecha_creacion, COUNT(sereno.id_sereno) as num_sere \n " +
        "FROM patrullaje LEFT JOIN sereno ON patrullaje.id_patrullaje = sereno.fk_patrullaje \n " +
        "INNER JOIN turno ON patrullaje.fk_turno = turno.id_turno \n " +
        "INNER JOIN unidad ON patrullaje.fk_unidad = unidad.id_unidad \n " +
        "INNER JOIN tipo_unidad ON unidad.fk_tipo_unidad = tipo_unidad.id_tipo_unidad \n " +
        "GROUP BY patrullaje.id_patrullaje, patrullaje.descripcion, turno.turno, tipo_unidad.tipo_unidad, unidad.placa, fecha_creacion \n " +
        "ORDER BY num_sere; "
    );

    res.send(result);
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Hubo un error",
    });
  }
};

export const getPatrullajes = async (req, res = response) => {
  try {
    /* const [result] = await pool.query(
      "SELECT id_patrullaje, patrullaje.descripcion, turno.turno, unidad.placa, tipo_unidad.tipo_unidad, \n " +
        "CASE \n " +
        "WHEN patrullaje.estado = 1 THEN 'Activo' \n " +
        "WHEN patrullaje.estado = 0 THEN 'Inactivo' \n " +
        "END AS estado \n " +
        "FROM patrullaje INNER JOIN turno ON patrullaje.fk_turno = turno.id_turno \n " +
        "INNER JOIN unidad ON patrullaje.fk_unidad = unidad.id_unidad \n " +
        "INNER JOIN tipo_unidad ON unidad.fk_tipo_unidad = tipo_unidad.id_tipo_unidad;"
    ); */

    const [result] = await pool.query(
      "SELECT id_patrullaje, patrullaje.descripcion, turno.turno, unidad.placa, tipo_unidad.tipo_unidad, \n " +
        "CASE \n " +
        "WHEN patrullaje.estado = 1 THEN 'Activo' \n " +
        "WHEN patrullaje.estado = 0 THEN 'Inactivo' \n " +
        "END AS estado, COUNT(sereno.id_sereno) AS num_sere\n" +
        "FROM patrullaje LEFT JOIN sereno ON patrullaje.id_patrullaje = sereno.fk_patrullaje \n " +
        "INNER JOIN turno ON patrullaje.fk_turno = turno.id_turno \n " +
        "INNER JOIN unidad ON patrullaje.fk_unidad = unidad.id_unidad \n " +
        "INNER JOIN tipo_unidad ON unidad.fk_tipo_unidad = tipo_unidad.id_tipo_unidad \n " +
        "GROUP BY id_patrullaje, patrullaje.descripcion, turno.turno, unidad.placa, tipo_unidad.tipo_unidad, estado \n " +
        "ORDER BY num_sere ASC;"
    );

    res.send(result);
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: "Hubo un error",
    });
  }
};

export const updatePatrullaje = async (req, res = response) => {
  const { desc, turno, unidad } = req.body;
  const { id } = req.params;

  const result = await pool.query("", []);
};
