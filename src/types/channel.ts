export default interface Channel {
  id:string,
  name:string,
  description?:string,
  server:string,
  category:string,
  created_at:Date
}