require("dotenv").config()

const express = require("express");
const path = require("path");
const app = express();

const cors = require("cors")
app.use(cors())

app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
  );
  
const router = require('../routes')
app.use(router)

app.use("/uploads", express.static(path.join(__dirname, "uploads")))

const port = process.env.PORT || 8080;

app.listen(port, () => {
  console.log(`Server is listening on port ${port}...`);
});