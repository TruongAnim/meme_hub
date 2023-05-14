const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/user')

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
      res.json({ token, ...user._doc });
    } catch (err) {
      next(err)
    }
  }
  async signup(req, res, next) {
    try {
      const { name, email, password } = req.body;
      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ msg: "email has been used!" });
      }
      const hashedPassword = await bcryptjs.hash(password, 10);
      var user = new User({ name, email, password: hashedPassword });
      user = await user.save();
      res.json(user);
    } catch (err) {
      next(err)
    }
  }
  getUser(req, res, next) {
    console.log('/api/get-user')
    try{
      res.json(req.user);
    } catch (err) {
      next(err)
    }
  }
}
module.exports = new AuthController()
