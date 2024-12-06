import dotenv from 'dotenv'

import App from './app'
import AuthController from './controllers/auth_controller'
import UserController from './controllers/user_controller'

dotenv.config()

const port = process.env.PORT || 3000
const app = new App([new UserController(), new AuthController()], port)

app.listen()
