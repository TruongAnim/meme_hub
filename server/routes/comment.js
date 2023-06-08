const express = require("express");
const router = express.Router();
const auth_passport = require("../middlewares/auth_passport");
const commentController = require("../app/controllers/comment_controller");

router.post("/new-comment", commentController.newComment);
router.post("/new-reply", commentController.newReply);
router.get("/get-comment", commentController.getComment);
router.get("/get-reply", commentController.getReply);

module.exports = router;
