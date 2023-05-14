const mongoose = require("mongoose");
const userScheme = mongoose.Schema({
  name: { type: String, default: "username" },
  email: {
    type: String,
    require: true,
    min: 10,
    trim: true,
    validate: {
      validator: (value) => {
        var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        return value.match(re);
      },
      message: "Invalid email",
    },
  },
  password: { type: String, require: true, min: 6, trim: true },
});

const User = mongoose.model("User", userScheme);
module.exports = User;