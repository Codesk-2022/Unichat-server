export default interface Message {
  id:string,
  user:string,
  content:string,
  server:string,
  channel:string,
  created_at:Date
}