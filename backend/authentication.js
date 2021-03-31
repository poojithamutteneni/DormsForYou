//Import
const express = require('express');
const bodyParser = require('body-parser')
require("dotenv").config();
var jwt = require('jsonwebtoken');
const tokenauth = require("./token");
const { Pool } = require('pg');


//initialize
const app = express.Router();



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


//booking
app.post('/authenticate', tokenauth, (req,res) =>{
if(tokenauth){
  res.send("Valid Token!");
} else {
  res.send("Please Sign in!");
}
})


 //login
  app.post('/login', async (req,res) =>{
    let email = req.body.email;
    let password = req.body.password;

    var myhashpass;
      await pool.query('SELECT * from register_user where email = $1',[email])
      .then((result) => {
      myhashpass = result.rows[0].password
      const matches = bcrypt.compareSync(password, myhashpass);
              if (matches) {
                  console.log('password matched');
                  var token = jwt.sign({email: email}, process.env.TOKEN_SECRET)
                  var user = result.rows[0];
                  delete user.password;
                  res.send({userdetails:user, token:token});
              } else {
                   res.send("password incorrect");
                       }
              })

      .catch((error) => {
              pool.end();
              console.log("Invalid login details");
          })
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


//export module
  module.exports = app;
