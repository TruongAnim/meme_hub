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
  async getPost(req, res, next) {
    try {
      const tag = req.params.tag;
      console.log("get post: " + tag);
      const query = tag == "all" ? {} : { tags: tag };
      const posts = await Post.find(query)
        .populate("userId")
        .sort({ createdAt: -1 }); // -1 for descending order, 1 for ascending order
      res.json(posts);
    } catch (err) {
      next(err);
    }
  }
  async upvote(req, res, next){
    try {
      const postId = req.body['postId'];
      const userId = req.body['userId'];
      const isUpvote = req.body['isUpvote'];
      var post = await Post.findById(postId);
      if (isUpvote){
        const indexToAdd = post.upVotes.indexOf(userId);
        if(indexToAdd == -1){
          post.upVotes.push(userId)
        }
      }else{
        const indexToRemove = post.upVotes.indexOf(userId);
        if (indexToRemove > -1) {
          post.upVotes.splice(indexToRemove, 1);
        }
      }
      post = await post.save();
      res.json(post);
    } catch (err) {
      next(err);
    }
  }
  async favourite(req, res, next){
    try {
      const postId = req.body['postId'];
      const userId = req.body['userId'];
      const isFavourite = req.body['isFavourite'];
      var post = await Post.findById(postId);
      if (isFavourite){
        const indexToAdd = post.favourites.indexOf(userId);
        if(indexToAdd == -1){
          post.favourites.push(userId)
        }
      }else{
        const indexToRemove = post.favourites.indexOf(userId);
        if (indexToRemove > -1) {
          post.favourites.splice(indexToRemove, 1);
        }
      }
      post = await post.save();
      res.json(post);
    } catch (err) {
      console.log(err)
      next(err);
    }
  }
}
module.exports = new PostController();
