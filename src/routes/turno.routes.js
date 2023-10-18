import { Router } from "express";
import { getTurnos } from "../controllers/turno.controller.js";

const router = Router();

router.get("/turnos", getTurnos);

export default router;
