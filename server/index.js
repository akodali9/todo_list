const express = require("express");
const Authrouter = require("./features/auth/auth");
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());



app.use('/auth',Authrouter);

app.get("/", (req, res) => {
  console.log("hello world!");
  res.send({ greeting: "hello" });
});

app.listen(port, "0.0.0.0", () => {
  console.log("Express app running!");
});