import express from "express";
import sqlite3 from "sqlite3";
const db = new sqlite3.Database("./unichat.db");
const app = express();

app.use(express.json(),express.urlencoded({ extended: true }));
app.listen(8000);
db.run("create table if not exists users(user,password,email)");
db.run("insert into users(user,password,email) values('example','example@example.com','test2022')")

app.post("/register", (req, res) => {
    //console.log(req.body);
    const email = req.body.email;
    const user = req.body.user;
    const password = req.body.password;
    if ((user == undefined||password == undefined||email == undefined) ){
        res.status(406).json({"msg":"Not Acceptable"});
    }else{
        db.get("select email from users where email=?",email,(err, row) => {
            console.log(row);
            if (err){
                console.log(err.msg);
            }
        });
        db.get("select user from users where user=?",user,(err, row) => {
            console.log(row);
            if (err){
                console.log(err.msg);
            }
        });
        db.run("insert into users(user,password,email) values(?,?,?)",user,password,email);
        console.log(`User:${user} registered`);
        res.status(201).json({"msg":"registered"});
    };
})

app.post("/login", (req, res) => {
    const email = req.body.email;
    const user = req.body.user;
    const password = req.body.password;
    if (user == null){}
    const token = jwt.sign({"user":user});
    res.status(200).json({"token":token})
})
