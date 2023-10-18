import { Router } from "express";
import { login, renewToken } from "../controllers/auth.controller.js";
import { validarJwt } from "../middlewares/validar-jwt.js";

// import controlles

const router = Router();

router.post("/auth", login);
router.get("/auth", validarJwt, renewToken);

export default router;
