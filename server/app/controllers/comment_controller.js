const User = require("../models/user");
const Post = require("../models/post");
const Comment = require("../models/comment");

class CommentController {
  async newComment(req, res, next) {
    try {
      const { userId, content, mediaLink, type, postId } = req.body;
      console.log({ userId, content, mediaLink, type });
      var comment = new Comment({ userId, content, mediaLink, type });
      comment = await comment.save();
      var post = await Post.findById(postId);
      post.comments.push(comment.id)
      post = await post.save();
      res.json(comment);
    } catch (err) {
      next(err);
    }
  }

  async getComment(req, res, next) {
    try {
      const { postId } = req.body;
      const post = await Post.findById(postId);
      const commentIds = post.comments;
      const comments = await Comment.find({ _id: { $in: commentIds } });
      res.json(comments);
    } catch (err) {
      next(err);
    }
  }
}
module.exports = new CommentController();
