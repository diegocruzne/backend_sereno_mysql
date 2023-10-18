import { Router } from "express";
import {
  actualizarUnidad,
  crearUnidad,
  getUnidadPorId,
  getUnidades,
  unidadesAvailables,
} from "../controllers/unidades.controller.js";

const router = Router();

router.get("/unidades", getUnidades);
router.get("/unidades/:id", getUnidadPorId);
router.get("/unidades/availables/:id_turno", unidadesAvailables);
router.post("/unidades", crearUnidad);
router.put("/unidades/:id", actualizarUnidad);

export default router;
