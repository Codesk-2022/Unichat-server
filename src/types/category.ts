export default interface Category {
  id:string,
  name:string,
  server:string,
  channels?:string[],
  created_at:Date
}