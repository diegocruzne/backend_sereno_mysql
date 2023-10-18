import { pool } from "../db.js";

export const ping = async (req, res) => {
  const [result] = await pool.query("SELECT CURRENT_TIMESTAMP() AS resultado");
  res.json(result[0]);
}; 
