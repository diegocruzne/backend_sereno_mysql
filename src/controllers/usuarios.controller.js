import { response } from "express";
import { pool } from "../db.js";
import { JWT_SECRET } from "../config.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";

export const updateMyUser = async (req, res = response) => {
  const { nombre, apellidos, nacimiento, correo, direccion, telefono, sexo, dni } = req.body;
  const { id } = req.params;

  try {
    const [result] = await pool.query(
      "UPDATE usuario \n " +
        "SET dni = ?, nombre = ?, apellido = ?, nacimiento = ?, correo = ?, \n " +
        "direccion = ?, telefono = ?, sexo = ? \n " +
        "WHERE id_usuario = ?;",
      [
        dni,
        nombre,
        apellidos,
        nacimiento,
        correo,
        direccion,
        telefono,
        sexo,
        id,
      ]
    );

    if (result.affectedRows === 1) {
      return res.json({
        ok: true,
        msg: "Usuario actualizado!",
      });
    } else {
      return res.status(400).json({
        ok: false,
        msg: "Error",
      });
    }
  } catch (err) {
    console.log(err);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }
};

export const changeMyPassword = async (req, res = response) => {
  const { oldPass, newPass, confirmPass } = req.body;
  const token = req.header("x-token");
  const id_user = jwt.verify(token, JWT_SECRET).id;

  try {
    const [result] = await pool.query(
      "SELECT id_usuario, dni, contrasena, fk_tipo_us FROM usuario WHERE id_usuario = ?",
      [id_user]
    );

    // Verificar contrasena actual
    const passOldUserDb = await result[0].contrasena;
    const passEncri = bcrypt.compareSync(oldPass, passOldUserDb);

    // Si contraseña actual es incorrecta
    if (!passEncri) {
      return res.status(400).json({
        ok: false,
        msg: "Verifique su contraseña",
      });
    }

    const newPassToDb = bcrypt.hashSync(newPass, bcrypt.genSaltSync());

    const [response] = await pool.query(
      "UPDATE usuario SET contrasena = ? WHERE id_usuario = ?",
      [newPassToDb, id_user]
    );

    if (response.affectedRows) {
      return res.json({
        ok: true,
        msg: "Contraseña actualizada!",
      });
    }
  } catch (err) {
    console.log(err);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }
};

export const createUser = async (req, res = response) => {
  const { dni, nombre, apellido, nacimiento, contrasena, correo, direccion, telefono, sexo, adicional } = req.body;  

  try {
    // Evaluar si existe dni, correo y telefono
    const [result] = await pool.query(
      "SELECT id_usuario FROM usuario WHERE dni = ? OR correo = ? OR telefono = ?",
      [dni, correo, telefono]
    );

    if (result.length > 0) {
      return res.status(400).json({
        ok: false,
        msg: "Dni, correo o celular ya existen",
      });
    }

    // Encriptar contrasena
    const salt = await bcrypt.genSalt();
    const passEncr = bcrypt.hashSync(contrasena, salt);

    await pool.query(
      "INSERT INTO usuario (dni, nombre, apellido, nacimiento, contrasena, correo, direccion, telefono, sexo, adicional, foto, fk_tipo_us) \n " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'user.png', 3)",
      [ dni, nombre, apellido, nacimiento, passEncr, correo, direccion, telefono, sexo, adicional ]
    );

    return res.json({
      ok: true,
      msg: "Usuario añadido correctamente",
    });
  } catch (error) {
    console.log(err);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }

};

export const getAllUsers = async (req, res = response) => {
  try {
    const [result] = await pool.query(
      "SELECT id_usuario, dni, nombre, apellido, nacimiento, contrasena, correo, direccion, telefono, sexo, adicional, foto, fk_tipo_us FROM usuario;"
    );
    return res.json(result);
  } catch (error) {
    console.log(error);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }
}; 

export const updateUserFromRoot = async (req, res = response) => {
  const { dni, nombre, apellidos, correo, nacimiento, direccion, telefono, sexo, contrasena, fk_tipo_us } = req.body;
  const { id } = req.params;
  const passEncri = contrasena
    ? bcrypt.hashSync(contrasena, bcrypt.genSaltSync())
    : null;

  try {

    const [result] = await pool.query(
      `UPDATE usuario SET dni = IFNULL(?, dni), nombre = IFNULL(?, nombre), apellido = IFNULL(?, apellido), nacimiento = IFNULL(?, nacimiento), 
        correo = IFNULL(?, correo), direccion = IFNULL(?, direccion), 
        telefono = IFNULL(?, telefono), sexo = IFNULL(?, sexo), contrasena = IFNULL(?, contrasena), fk_tipo_us = IFNULL(?, fk_tipo_us) 
        WHERE id_usuario = ?;`,
      [ dni, nombre, apellidos, nacimiento, correo, direccion, telefono, sexo, passEncri, fk_tipo_us, id ]
    );

    if (result.affectedRows === 1) {
      return res.json({
        ok: true,
        msg: "Usuario actualizado!",
      });
    } else {
      throw new Error("Error en la actualización de ususario(s)");
    } 
  } catch (err) {
    console.log(err);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }
}; 

export const getUserById = async (req, res = response) => {
  const { id } = req.params;

  const [result] = await pool.query(
    `SELECT id_usuario, dni, nombre, apellido, nacimiento, contrasena, 
      correo, direccion, telefono, sexo, adicional, foto, fk_tipo_us
      FROM usuario
      WHERE id_usuario = ?;`,
    [id]
  );

  res.json(result[0]);
}