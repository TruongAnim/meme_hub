authRouter = require('./auth')
postRouter = require('./post')
commentRouter = require('./comment')

function route(app){
  app.use('/api/post', postRouter)
  app.use('/api/comment', commentRouter)
  app.use('/api', authRouter)

  app.use('/', (req, res, next)=>{
    res.render('index', {title:'Home Page'})
  })
}
module.exports = route;
