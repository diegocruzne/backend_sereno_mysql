import bcrypt from "bcryptjs";
import { response } from "express";
import { pool } from "../db.js";
import { generarJwt } from "../helpers/jwt.js";

export const login = async (req, res = response) => {
  const { dni, password } = req.body;

  try {
    const [result] = await pool.query(
      "SELECT id_usuario, dni, contrasena, id_tipo_us FROM usuario inner join tipo_usu on usuario.fk_tipo_us = tipo_usu.id_tipo_us WHERE dni = ?",
      [dni]
    );

    if (result.length < 1) {
      return res.status(400).json({
        ok: false,
        msg: "Dni no existe",
      });
    }

    const passSql = result[0].contrasena;
    const id = result[0].id_usuario;

    // Encriptar contraseña
    const passEncri = bcrypt.compareSync(password, passSql);

    if (!passEncri) {
      return res.status(400).json({
        ok: false,
        msg: "contrasena no valida",
      });
    }

    // Generar token
    const token = await generarJwt(id);

    res.json({
      ok: true,
      token,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      ok: false,
      msg: "Error inesperado",
    });
  }
};

export const renewToken = async (req, res = response) => {
  if (!req.id) {
    return res.status(400).json({
      ok: false,
      msg: "Verificar que token exista",
    });
  }

  const id = req.id.toString();

  // Generar jwt
  const token = await generarJwt(id);
  

  // Obtener usuario por id
  const [result] = await pool.query(
    "select id_usuario, dni, nombre, apellido, nacimiento, correo, direccion, telefono, sexo, adicional, foto, fk_tipo_us  from usuario where id_usuario = ?",
    [id]
  );

  res.json({
    ok: true,
    token,
    usuario: result[0],
  });
};
