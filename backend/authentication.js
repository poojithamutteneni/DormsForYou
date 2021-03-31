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


//authenticate
app.post('/authenticate', tokenauth, (req,res) =>{
if(tokenauth){
  res.send("Valid Token!");
} else {
  res.status(500);
  res.send("Please Sign in!");
}
})


 //login
  app.post('/login', async (req,res) =>{
    let {email,password}=req.headers;
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
                   res.status(500);
                   res.send("password incorrect");
                       }
              })

      .catch((error) => {
               pool.end();
              res.status(500);
              console.log("Invalid login details");
          })
    })




  //signup
  app.post('/signup', (req, res) => {
  let {full_name,email,dob,password}=req.headers;
    bcrypt.genSalt(saltRounds, function (err, salt) {
          bcrypt.hash(password, salt, function (err, hash) {
              pool.query("INSERT INTO register_user(full_name,email,dob,password) VALUES ($1, $2, $3, $4)", [full_name, email, dob, hash],
                  function (err, result) {
                      if (err) {
                          res.status(500);
                          console.log(err);
                      } else {
                          console.log('New user entered');
                          var token = jwt.sign({email: email}, process.env.TOKEN_SECRET)
                          res.send({userdetails:{full_name: full_name, email: email}, token:token});
                      }
                  });
          });
      });
    })


//export module
  module.exports = app;
