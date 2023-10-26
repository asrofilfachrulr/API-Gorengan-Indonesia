const express = require('express');
const router = express.Router();
const pool = require('../config/db');

const jwtMiddleware = require('../tokenize')

const users = require('../handlers/users')
const auth = require('../handlers/auth')

router.post("/register", users.postNewUserHandler(pool))
router.post("/login", auth.postLoginHandler(pool))

module.exports = router