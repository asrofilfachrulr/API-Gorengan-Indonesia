const express = require('express');
const router = express.Router();
const pool = require('../config/db');

const jwtMiddleware = require('../tokenize')

const users = require('../handlers/users')

const auth = require('../handlers/auth')

// public routes
router.post("/register", users.postNewUserHandler(pool))
router.post("/login", auth.postLoginHandler(pool))

// protected routes
router.get("user", jwtMiddleware, users.getUserHandler(pool))
// router.put("user/image", jwtMiddleware, userUpload.single('image'), users.putUserImageHandler)

// router.post("receipt")
// router.post("receipt/image")
// router.get("receipt/my")

module.exports = router