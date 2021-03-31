require("dotenv").config();
const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    if(authHeader)
    {
        const token = authHeader.split(' ')[1];
        console.log(token);
        jwt.verify(token, process.env.TOKEN_SECRET, (err, decoded) =>{
            console.log(err);
            if(err){
              res.status(500);
              return res.send({error: "Please Sign in!"});
            }
            else
            {
                // set the user object in the request.
                req.user = decoded;
                return next();
            }
        })
    }
    else
        res.json({error: "Improper Authorization header"});
}
