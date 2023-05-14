authRouter = require('./auth')

function route(app){
  app.use('/api', authRouter)

  app.use('/', (req, res, next)=>{
    res.render('index', {title:'Home Page'})
  })
}
module.exports = route;
