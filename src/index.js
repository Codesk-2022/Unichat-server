import express from "express";
import bodyparser from "body-parser";
import Client from "pg";

const app = express();
app.use(bodyparser.json());
const client = new Client({
    user: 'test0',
    host: 'localhost',
    database: 'test_db',
    password: 'test',
    port: 5432
});
//client.connect()

app.post("/api/user/signup", (req, res) => {
    //console.log(req.body);
    res.status(200).json({
        message: 'Hello!'
    });
});

app.post("/api/user/login", (req,res) => {
    console.log(req);
});

app.listen(3000);
