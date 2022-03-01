export default interface User {
  id:string,
  email:string,
  username:string,
  password:string,
  tag:number,
  registered_at:Date,
  verified:boolean
}