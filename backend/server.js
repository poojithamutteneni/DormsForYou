//Import
const express = require('express');
const bodyParser = require('body-parser')
require("dotenv").config();
var jwt = require('jsonwebtoken');
const { Pool, Client } = require('pg');

//initialization
const app = express();
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())



//PORT
const PORT = process.env.PORT || 6000;


//db connection
const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database: "dormsforyou",
    password: process.env.p,
    port: 5432
});




//bcrypt hashing
const bcrypt = require('bcrypt');
const saltRounds = 10;


app.get("/", (req,res)=>{
	res.send("Find your Dorm");
})


//signup
app.post('/signup', (req, res) => {
let {full_name,email,dob,college_name,password}=req.body;
  bcrypt.genSalt(saltRounds, function (err, salt) {
        bcrypt.hash(password, salt, function (err, hash) {
            pool.query("INSERT INTO register_user(full_name,email,dob,college_name,password) VALUES ($1, $2, $3, $4, $5)", [full_name, email, dob, college_name, hash],
                function (err, result) {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log('New user entered');
                    }
                });
        });
    });
  })



  //login
  app.post('/login', async (req,res) =>{
  let email = req.body.email;
  let password = req.body.password;

  var myhashpass;
    await pool.query('SELECT password from register_user where email = $1',[email])
    .then((result) => {
    myhashpass = result.rows[0].password
    const matches = bcrypt.compareSync(password, myhashpass);
            if (matches) {
                console.log('password matched');
            } else {
                 console.log("password incorrect");
                     }
            })

    .catch((error) => {
            pool.end();
            console.log("Invalid login details");
        })
  })



//get colleges
app.post('/getcolleges', (req,res) =>{
let name = req.body.name;
  pool.query("Select * from colleges where college_name like '$name*' ",
      function (err, result) {
          if (err) {
              console.log(err);
          } else {
              console.log('Colleges retervied');
          }
      });
})



//get hostels
app.post('/getcolleges', (req,res) =>{


})



//getHostelsNearbyCurrentLocation
app.post('/getHostelsNearbyCurrentLocation', (req,res) =>{

});




//Listening
app.listen(PORT, function(){
  console.log("server is listening", PORT);
});
