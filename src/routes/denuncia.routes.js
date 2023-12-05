import { Router } from "express";
import { validarJwt } from "../middlewares/validar-jwt.js";
import {
  buscarDenunciasPorFecha,
  listarDenuncias,
  registrarDenuncia,
} from "../controllers/denuncia.controller.js";

const router = Router();

router.get("/denuncia", validarJwt, listarDenuncias);
router.get("/denuncia_buscar", validarJwt, buscarDenunciasPorFecha);
router.post("/denuncia", validarJwt, registrarDenuncia)

export default router;
