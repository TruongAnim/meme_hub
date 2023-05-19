const User = require("../models/user");
const Post = require("../models/post");
const Comment = require("../models/comment");

class PostController {
  async newPost(req, res, next) {
    try {
      const { tags, title, mediaLink } = req.body;
      console.log({ userId: req.user.id, tags, title, mediaLink });
      var post = new Post({ userId: req.user.id, tags, title, mediaLink });
      post = await post.save();
      res.json(post);
    } catch (err) {
      next(err);
    }
  }
}
module.exports = new PostController();
