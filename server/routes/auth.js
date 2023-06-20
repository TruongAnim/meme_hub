const express = require("express");
const router = express.Router();
const authController = require("../app/controllers/auth_controller");
const auth_passport = require('../middlewares/auth_passport')

/* GET users listing. */
router.post('/login', authController.login);
router.post('/signup', authController.signup);
router.get('/get-user', auth_passport, authController.getUser)
router.post('/update-user-info', auth_passport, authController.updateUserInfo)

module.exports = router;
