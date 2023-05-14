const express = require("express");
const router = express.Router();
const authController = require("../app/controllers/auth_controller");

/* GET users listing. */
router.get('/login', authController.login);
router.get('/signup', authController.signup);

module.exports = router;
