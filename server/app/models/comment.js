const mongoose = require("mongoose");
const commentScheme = mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", require: true },
    upVotes: [{
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      require: true,
    }],
    downVotes: [{
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      require: true,
    }],
    content: { type: String, require: true},
    mediaLink: { type: String, require: true},
    createdAt: {
      type: Date,
      default: Date.now,
    }
});

const Comment = mongoose.model("Comment", commentScheme);
module.exports = Comment;