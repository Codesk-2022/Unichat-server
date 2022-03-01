import Ajv from "ajv";

const ajv = new Ajv();
const {Pool} = await import("pg");

const getProp=(o,k,t=null)=>{
  if (o[k]==null){
    throw new Error(`❌ ${k} is null`);
  }
  if (t && (typeof o[k] == t))throw new Error(`❌ invalid type! key: ${k} Expected type: ${t}`);
  return o[k];
};

export const genConf = ()=>{
  return {
    user: getProp(process.env,"postgresUser"),
    host: getProp(process.env,"postgresHost"),
    database: getProp(process.env,"postgresDB"),
    password: getProp(process.env,"postgresPass"),
    port: parseInt(getProp(process.env,"postgresPort"))
  }
}

export const newPool = (merge={})=>new Pool({
  ...genConf(),
  ...merge
})