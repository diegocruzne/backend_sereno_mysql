import express from "express";
import cors from "cors";
import serenosRoutes from "./routes/serenos.routes.js";
import indexRoutes from "./routes/index.routes.js";
import authRoutes from "./routes/auth.routes.js";
import usuariosRoutes from "./routes/usuarios.routes.js";
import unidadesRoutes from "./routes/unidades.routes.js";
import patrullajeRoutes from "./routes/patrullaje.routes.js"
import turnoRoutes from "./routes//turno.routes.js"

const app = express();

app.use(express.json());

// Cors
app.use(cors());

app.use(indexRoutes);
app.use(serenosRoutes);
app.use(authRoutes);
app.use(usuariosRoutes);
app.use(unidadesRoutes);
app.use(patrullajeRoutes);
app.use(turnoRoutes);

export default app;
