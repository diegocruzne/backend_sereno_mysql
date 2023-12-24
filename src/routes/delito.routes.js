import { Router } from "express";
import { validarJwt } from "../middlewares/validar-jwt.js";
import { getDelitoPorCategorias } from "../controllers/delito.controller.js";

const router = Router();

router.get("/delito", validarJwt, getDelitoPorCategorias);

export default router;
