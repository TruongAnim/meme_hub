const express = require("express");
const router = express.Router();
const userController = require("../app/controllers/user_controller");
const auth_passport = require("../middlewares/auth_passport");

router.get("/get-user-info", auth_passport, userController.getUserInfo);
router.get("/get-user", auth_passport, userController.getUser);
router.post("/update-user-info", auth_passport, userController.updateUserInfo);
router.post("/change-password", auth_passport, userController.changePassword);

module.exports = router;
