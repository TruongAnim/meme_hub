const mongoose = require("mongoose");
async function connect() {
  try {
    await mongoose.connect("mongodb://127.0.0.1:27017/meme_hub");
    console.log("Connect to db successfully");
  } catch (e) {
    console.log(e);
  }
}

module.exports = { connect };
