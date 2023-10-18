import { response } from "express";
import { pool } from "../db.js";
import { JWT_SECRET } from "../config.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";

export const updateMyUser = async (req, res = response) => {
  const {
    nombre,
    apellidos,
    nacimiento,
    correo,
    direccion,
    telefono,
    sexo,
    dni,
  } = req.body;
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
