authRouter = require('./auth')

function route(app){
  app.use('/', (req, res, next)=>{
    res.render('index', {title:'Home Page'})
  })
  app.use('/api', authRouter)
}
module.exports = route;
