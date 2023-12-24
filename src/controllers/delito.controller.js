import { response } from "express";
import { pool } from "../db.js";

export const getDelitoPorCategorias = async (req, res = response) => {
  const [results] = await pool.query(
    `SELECT td.tipo_delito AS tipo_delito, d.id_delito AS id, d.delito AS nombre
  FROM tipo_delito td JOIN delito d ON td.id_tipo_delito = d.tipo_delito_fk;`
  );

  const formattedData = formatData(results);

  res.send(formattedData);
};

const formatData = (results) => {
  const formattedData = [];

  results.forEach((data) => {
    const existingType = formattedData.find(
      (item) => item.tipo_delito === data.tipo_delito
    );

    if (existingType) {
      existingType.delito.push({ id: data.id, nombre: data.nombre });
    } else {
      formattedData.push({
        tipo_delito: data.tipo_delito,
        delito: [{ id: data.id, nombre: data.nombre }],
      });
    }
  });

  return formattedData;
};
