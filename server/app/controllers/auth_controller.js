const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");

class AuthController {
  async login(req, res, next) {
    try {
      const { email, password } = req.body;
      const user = await User.findOne({ email });
      if (!user) {
        return res.status(400).json({ msg: "User dose not exist!" });
      }
      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password!" });
      }
      const token = jwt.sign({ id: user._id }, "passwordKey");
      res.json({
        _id: user._id,
        name: user.name,
        email: user.email,
        description: user.description,
        avatar: user.avatar,
        token,
      });
    } catch (err) {
      next(err);
    }
  }
  async signup(req, res, next) {
    try {
      const { name, email, password } = req.body;
      console.log({ name, email, password });
      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ msg: "email has been used!" });
      }
      const hashedPassword = await bcryptjs.hash(password, 10);
      var user = new User({ name, email, password: hashedPassword });
      user = await user.save();
      res.json(user);
    } catch (err) {
      next(err);
    }
  }
  async changePassword(req, res, next) {
    try {
      const oldPassword = req.body.oldPassword;
      const newPassword = req.body.newPassword;
      var user = await User.findById(req.user._id);
      const isMatch = await bcryptjs.compare(oldPassword, user.password);
      if (isMatch) {
        const hashedPassword = await bcryptjs.hash(newPassword, 10);
        user.password = hashedPassword;
        user = await user.save();
        return res.json({
          status: "success",
          message: "Password changed successfully",
        });
      } else {
        return res.json({
          status: "fail",
          message: "Invalid current password",
        });
      }
    } catch (err) {
      next(err);
    }
  }
  async getUser(req, res, next) {
    try {
      var user = await User.findById(req.user._id);
      res.json(user);
    } catch (err) {
      next(err);
    }
  }
  async getUserInfo(req, res, next) {
    console.log("/api/get-user-info");
    try {
      var user = await User.findById(req.body["userId"]);
      res.json(user);
    } catch (err) {
      next(err);
    }
  }
  async updateUserInfo(req, res, next) {
    try {
      const { name, description, avatar } = req.body;
      console.log(`/api/update-user-info ${name}, ${description}, ${avatar}`);
      const id = req.user.id;
      var user = await User.findById(id);
      if (name && name.length > 0) {
        user.name = name;
      }
      if (description && description.length > 0) {
        user.description = description;
      }
      if (avatar && avatar.length > 0) {
        user.avatar = avatar;
      }
      await user.save();
      res.status(200).json({
        success: true,
        message: "Information updated successfully",
        data: {
          name,
          description,
          avatar,
        },
      });
    } catch (err) {
      next(err);
    }
  }
}
module.exports = new AuthController();
