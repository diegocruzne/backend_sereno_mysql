import { pool } from "../db.js";
import { response } from "express";

export const getSerenos = async (req, res) => {
  const [result] = await pool.query(
    "SELECT id_sereno, dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento, imagen, \n " +
      "YEAR(CURDATE()) - YEAR(nacimiento) AS edad, fk_patrullaje from sereno;"
  );
  res.json(result);
};

export const createSereno = async (req, res) => {
  const {
    dni,
    nombre,
    apellidos,
    genero,
    celular,
    correo,
    direccion,
    nacimiento,
  } = req.body;
  const [rows] = await pool.query(
    "INSERT INTO sereno (dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
    [dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento]
  );
  res.json({
    dni,
    nombre,
    apellidos,
    genero,
    celular,
    correo,
    direccion,
    nacimiento,
  });
};

export const getSerenoById = async (req, res) => {
  const { id } = req.params;
  const [result] = await pool.query(
    "select id_sereno, dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento, imagen, \n " +
      "YEAR(CURDATE()) - YEAR(nacimiento) AS edad, fk_patrullaje from sereno where id_sereno = ?",
    [id]
  );
  res.json(result[0]);
};

export const updateSerenoById = async (req, res) => {
  const { id } = req.params;
  const {
    dni,
    nombre,
    apellidos,
    genero,
    celular,
    correo,
    direccion,
    nacimiento,
  } = req.body;
  const [result] = await pool.query(
    "UPDATE sereno \n " +
      "SET dni = ?  \n " +
      ",nombre = ? \n " +
      ",apellidos = ? \n " +
      ",genero = ? \n " +
      ",celular = ? \n " +
      ",correo = ? \n " +
      ",direccion = ? \n " +
      ",nacimiento = ? \n " +
      "WHERE id_sereno = ? ",
    [dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento, id]
  );
  res.json({
    dni,
    nombre,
    apellidos,
    genero,
    celular,
    correo,
    direccion,
    nacimiento,
  });
};

export const deleteSereno = async (req, res) => res.send("eliminando serenos");

export const updateSerenoFkPatrullaje = async (req, res = response) => {
  const { id_sereno, fk_patrullaje } = req.body;

  const result = await pool.query(
    "UPDATE sereno SET fk_patrullaje = ? WHERE id_sereno = ?",
    [fk_patrullaje, id_sereno]
  );

  res.status(200).json({
    ok: true,
    msg: "Sereno actualizado",
  });
};

export const deleteSerenoById = async (req, res = response) => {
  const { id } = req.params;

  const result = await pool.query("DELETE FROM sereno WHERE id_sereno = ?", [
    id,
  ]);

  res.sendStatus(204);
};
