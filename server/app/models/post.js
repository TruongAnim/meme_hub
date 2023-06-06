const mongoose = require("mongoose");
const postScheme = mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", require: true },
  comments: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "Comment",
    require: true,
  }],
  upVotes: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    require: true,
  }],
  favourites: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    require: true,
  }],
  tags: {
    type: [String],
    require: true,
  },
  title: { type: String, require: true},
  mediaLink: { type: String, require: true},
  createdAt: {
    type: Date,
    default: Date.now,
  }
});

const Post = mongoose.model("Post", postScheme);
module.exports = Post;
