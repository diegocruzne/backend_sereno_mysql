import { pool } from "../db.js";

export const ping = async (req, res) => {
  const [result] = await pool.query("SHOW VARIABLES LIKE 'version%';");
  res.json(result);
}; 
