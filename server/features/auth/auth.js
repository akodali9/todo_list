const express = require("express");
const Authrouter = express.Router();
const jwt = require("jsonwebtoken");

const users = [
  {
    id: 1,
    username: "user1",
    password: "pass1",
  },
  {
    id: 2,
    username: "user2",
    password: "pass2",
  },
];

const jwtsecretkey = "dfkjf3kejfklenuy@F$^VJHbn";

Authrouter.post('/signin', (req,res)=>{
    console.log("Sign-in requested")
    const {username, password} = req.body;

    const user = users.find((subuser)=> subuser.username == username);

    if (!user || user.password !== password){
        return res.status(401).json({message: 'Inavlid Username or Password'});
    }

    const token = jwt.sign({userId : user.id}, jwtsecretkey);

    res.json({token});
});

module.exports = Authrouter;