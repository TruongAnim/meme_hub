const express = require("express");
const router = express.Router();
const auth_passport = require("../middlewares/auth_passport");
const commentController = require("../app/controllers/comment_controller");

router.post("/new-comment", commentController.newComment);
router.get("/get-comment", commentController.getComment);

module.exports = router;
