//Import
const express = require('express');
const bodyParser = require('body-parser')
require("dotenv").config();
var jwt = require('jsonwebtoken');
const { Pool, Client } = require('pg');
const tokenauth = require("./token");
const authentication = require("./authentication");
const requests = require("./requests");
const cors = require('cors');




//PORT
const PORT = process.env.PORT || 6000;


//Initialize
const app = express();
app.use(cors())
app.use(express.urlencoded({ extended: true }))
app.use(express.json())
app.use('/auth',authentication)
app.use('/request', requests)
app.use(express.static('public'))



//Listening
app.listen(PORT, function(){
  console.log("server is listening", PORT);
});
