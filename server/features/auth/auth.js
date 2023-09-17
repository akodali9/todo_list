const express = require("express");
const Authrouter = express.Router();
const jwt = require("jsonwebtoken");
const User = require("../../models/user");

const users = [
  {
    id: 1,
    email: "user1@gmail.com",
    password: "pass1",
  },
  {
    id: 2,
    email: "user2@gmail.com",
    password: "pass2",
  },
];

const jwtsecretkey = "dfkjf3kejfklenuy@F$^VJHbn";

Authrouter.post("/signup", (req, res) => {
  console.log("Sign-up requested");

  try {
    const { email, password } = req.body;
    const isExisting = User.findOne({ email });

    if (isExisting) {
      res
        .status(400)
        .send({ msg: "User with the same email id already exists." });
    }

    let user = User({
      email,
      password
    });

    user = user.save();
    res.status(200).json({ user });
  } catch (e) {
    res.status(500).send({ error: e.message });
  }
});

Authrouter.post("/signin", (req, res) => {
  console.log("Sign-in requested");
  const { email, password } = req.body;

  const user = users.find((subuser) => subuser.email == email);

  if (!user || user.password !== password) {
    return res.status(401).json({ message: "Invalid Username or Password" });
  }

  const token = jwt.sign({ useremail: user.email }, jwtsecretkey);

  res.status(200).json({ token });
});

module.exports = Authrouter;
