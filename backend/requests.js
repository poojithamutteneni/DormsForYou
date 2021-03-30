//Import
const express = require('express');
const bodyParser = require('body-parser')
require("dotenv").config();
var jwt = require('jsonwebtoken');
const { Pool, Client } = require('pg');
const tokenauth = require("./token");



//Initialize
const app = express.Router();
app.use(express.urlencoded({ extended: true }))
app.use(express.json())




//db connection
const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database: "dormsforyou",
    password: "password",
    port: 5432
});




//get colleges
app.post('/getcollegesbyname',  async (req,res) =>{
let name = req.headers["name"]+ "%";
try{
  let result = await pool.query("Select * from colleges where college_name like $1 " ,[name] );
      res.send(result.rows);
    }
  catch(error) {
    console.log(error);
  }
})




//get hostels by name
app.post('/gethostelsbyname', async (req,res) =>{
let name = req.headers["name"]+ "%";
console.log(name);
try{
  let result = await pool.query("Select * from hostels where name like $1 " ,[name] );
      res.send(result.rows);
    }
  catch(error) {
    console.log(error);
  }
})






//get hostels by cid
app.post('/gethostelsbycid', (req,res) =>{
 let cid = parseInt(req.headers["cid"]);
 console.log(cid);
 pool.query("select name from hostels join HostelsColleges on  HostelsColleges.cid = $1 group by hostels.name ",[cid],
     function (err, result) {
         if (err) {
             console.log(err);
         } else {
             res.send(result.rows);
         }
     });

})





//getHostelsNearbyCurrentLocation
app.post('/getHostelsNearbyCurrentLocation', async (req,res) =>{
  let minlat =  parseFloat(req.headers["latitude"]) - 0.5;
  let maxlat =  parseFloat(req.headers["latitude"]) + 0.5;
  let minlon =  parseFloat(req.headers["longitude"]) - 0.5;
  let maxlon =  parseFloat(req.headers["longitude"]) + 0.5;
  let hostels;
  try{
  for(let i = 0; i <= 2; ){
    let r = await pool.query("Select * from hostels where latitude >= $1 AND latitude <= $2 AND longitude >= $3 AND longitude <= $4; ", [minlat, maxlat, minlon,maxlon]);
    hostels = (r.rows);
    
    if(r.rows.length > 0) i++;
    // console.log(minlat + " " + maxlat);
      minlat -= 0.5;  maxlat += 0.5; minlon -= 0.5; maxlon += 0.5;
      }
      res.send(hostels);
    // console.log(hostels.length);
}
catch(error){
  console.log(error);
}
});



//booking
app.post('/book', tokenauth, (req,res) =>{
if(tokenauth){
  res.send("Dorm has been booked!");
} else {
  res.send("Please Sign in!");
}
})



//export module
module.exports = app;
