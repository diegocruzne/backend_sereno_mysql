import jwt from "jsonwebtoken";
import { JWT_SECRET } from "../config.js";

export const validarJwt = (req, res, next) => {
  const token = req.header("x-token");

  if (!token) {
    return res.status(401).json({
      ok: false,
      msg: "No hay token en la petición",
    });
  }

  try {
    const id = jwt.verify(token, JWT_SECRET).id;
    req.id = id;
    next();
  } catch (err) {
    return res.status(401).json({
      ok: false,
      msg: "Token no válido o vencido",
    });
  }
};
