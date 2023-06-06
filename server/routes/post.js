const express = require("express");
const router = express.Router();
const auth_passport = require("../middlewares/auth_passport");
const postController = require("../app/controllers/post_controller");

/* GET users listing. */
router.post("/new-post", auth_passport, postController.newPost);
router.get("/get-post/:tag", postController.getPost);
router.post("/upvote", postController.upvote);
router.post("/favourite", postController.favourite);

module.exports = router;
