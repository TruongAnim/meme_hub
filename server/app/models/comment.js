const mongoose = require("mongoose");
const commentScheme = mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", require: true },
  upVotes: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      require: true,
    },
  ],
  favourites: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    require: true,
  }],
  type: { type: String, require: true },
  content: { type: String, require: true },
  mediaLink: { type: String },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Comment = mongoose.model("Comment", commentScheme);
module.exports = Comment;
