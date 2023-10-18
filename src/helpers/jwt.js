import jwt from "jsonwebtoken";
import { JWT_SECRET } from "../config.js";

export const generarJwt = (id) => {
  return new Promise((resolve, reject) => {
    const payload = { id };

    jwt.sign(payload, JWT_SECRET, { expiresIn: "12h" }, (err, token) => {
      if (err) {
        console.log(err);
        reject("No se puedo generar el jwt");
      } else {
        resolve(token);
      }
    });
  });
};
