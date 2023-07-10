const mongoose = require("mongoose");
async function connect() {
  try {
    // await mongoose.connect("mongodb://127.0.0.1:27017/meme_hub");
    // admin@123 -> admin%40123
    await mongoose.connect("mongodb+srv://meme_hub_admin:admin%40123@memedb01.illfamh.mongodb.net/?retryWrites=true&w=majority");
    
    console.log("Connect to db successfully");
  } catch (e) {
    console.log(e);
  }
}

module.exports = { connect };
