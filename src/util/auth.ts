//#region modules
  import {Buffer} from "buffer";
  import { Request } from "express";

//#endregion modules

//#region local_modules
  import {newPool} from "../sql/postgres.js";

//#endregion local_modules

export const pool = newPool();

export const parseBasic = (b64)=>Buffer.from(b64,"base64").toString("ascii").split(":",1);

export const basicAuth = async(req:Request)=>{
  const authHeader:unknown = req.headers.Authenticate;
  if (typeof authHeader !== "string")return false;
  const client = await pool.connect();
  const [email,password] = parseBasic(authHeader.split(" ")[1]);
  try {
    const {rows:[user]} = await client.query(
      `SELECT (email, username, password) FROM users WHERE email=$1 AND password=digest($2,"sha256") LIMIT 1`,
      [
        email,
        password
      ]
    );
    if (user!=null)return false;
    else return user;
  }finally {
    client.release();
  }
};

export default basicAuth;