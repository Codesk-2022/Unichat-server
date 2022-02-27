export default interface Server {
  id:string,
  name:string,
  owner:string,
  categories?:string[],
  emojis?:string[],
  stamps?:string[],
  created_at:Date
}