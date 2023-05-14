class AuthController {
  login(req, res, next) {
    try {
      res.json({ res: "login" });
    } catch (err) {
      next(err);
    }
  }
  signup(req, res, next) {
    try {
      res.json({ res: "signup" });
    } catch (err) {
      next(err);
    }
  }
  getUser(req, res, next) {
    try {
      res.json({ res: "getuser" });
    } catch (err) {
      next(err);
    }
  }
}
module.exports = new AuthController()
