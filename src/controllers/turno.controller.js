import { response } from "express";
import { pool } from "../db.js";

export const getTurnos = async (req, res = response) => {
  const [result] = await pool.query("SELECT * FROM turno");

  res.send(result);
};
