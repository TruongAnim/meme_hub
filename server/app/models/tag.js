const mongoose = require("mongoose");
const tagScheme = mongoose.Schema({
  name: { type: String, require: true },
  posts: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      require: true,
    },
  ],
  icon: { type: String, require: true },
});
const Tag = mongoose.model("Tag", tagScheme);
module.exports = Tag;
