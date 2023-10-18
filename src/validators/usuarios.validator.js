import { check } from "express-validator";
import { validarCampos } from "../middlewares/validar-campos.js";

export const validatePasswords = [
  check("oldPass", "Es requerida su contraseña actual").not().isEmpty(),
  check("newPass", "Es requerida su nueva contraseña").not().isEmpty(),
  check("newPass", "Debe de ser de más de 6 digitos").isLength({ min: 6 }),
  check("confirmPass", "Debe ingresar su contraseña nueva dos veces").not().isEmpty(),
  check("confirmPass", "Escriba de nuevo su contraseña").custom(
    (confirmPass, { req }) => {
      if (confirmPass !== req.body.newPass) {
        throw new Error("Contraseñas incorrectas");
      }
      return true;
    }
  ),
  validarCampos,
];
