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

Authrouter.post("/signup", async (req, res) => {
  console.log("Sign-up requested");

  try {
    const { email, password } = req.body;

    const isExisting = await User.findOne({ email });

    console.log(`find one: ${isExisting}`);

    if (isExisting) {
      return res
        .status(400)
        .send({ msg: "User with the same email id already exists." });
    }

    let user = User({
      email,
      password,
    });
    try {
      user = user.save();
      
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
    res.status(200).json({ validation: "true" });
  } catch (e) {
    res.status(500).send({ error: e.message });
  }
});

Authrouter.post("/signin", async (req, res) => {
  console.log("Sign-in requested");
  const { email, password } = req.body;

  const user = await User.findOne({ email });

  const userFound = User(user);
  console.log(`found email: ${userFound}`);

  if (!user || user.password !== password) {
    return res.status(401).json({ message: "Invalid Username or Password" });
  }

  const token = jwt.sign({ email }, jwtsecretkey);

  res.status(200).json({ token, user });
});

module.exports = Authrouter;
