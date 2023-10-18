import { Router } from "express";
import { validarJwt } from "../middlewares/validar-jwt.js";
import {
  getPatrullajePorId,
  newPatrullaje,
  getPatrullajes_detalles,
  getPatrullajes,
  updatePatrullaje,
} from "../controllers/patrullaje.controller.js";

const router = Router();

router.get("/patrullaje", validarJwt, getPatrullajes);
router.get("/patrullaje/:id", validarJwt, getPatrullajePorId);
router.post("/patrullaje", validarJwt, newPatrullaje);
router.put("/patrullaje/:id", validarJwt, updatePatrullaje);
router.get("/patrullaje_det", validarJwt, getPatrullajes_detalles);

export default router;
