authRouter = require('./auth')

function route(app){
  app.use('/api', authRouter)
}
module.exports = route;
