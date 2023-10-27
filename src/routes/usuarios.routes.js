import { Router } from "express";
import {
  changeMyPassword,
  createUser,
  getAllUsers,
  updateMyUser,
} from "../controllers/usuarios.controller.js";
import { validarJwt } from "../middlewares/validar-jwt.js";
import { validatePasswords } from "../validators/usuarios.validator.js";

const router = Router();

router.put("/usuarios/:id", validarJwt, updateMyUser);
router.post("/usuarios_changemypassword", validatePasswords, validarJwt, changeMyPassword);
router.post("/usuarios", validarJwt, createUser);
router.get("/usuarios", validarJwt, getAllUsers)

export default router;
