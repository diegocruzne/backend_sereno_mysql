import { Router } from "express";
import {
  getSerenos,
  createSereno,
  updateSerenoById,
  getSerenoById,
  updateSerenoFkPatrullaje,
  deleteSerenoById,
} from "../controllers/serenos.controller.js";

const router = Router();

router.get("/serenos", getSerenos);
router.get("/serenos/:id", getSerenoById);
router.post("/serenos", createSereno);
router.put("/serenos/:id", updateSerenoById);
router.put("/serenos_patrullaje", updateSerenoFkPatrullaje);
router.delete("/serenos/:id", deleteSerenoById);

export default router;
