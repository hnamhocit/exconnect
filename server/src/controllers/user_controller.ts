import express from 'express'
import jwt from 'jsonwebtoken'

import HttpException from '../exceptions/http'
import { JWTPayload } from '../types/payload'
import { BaseController } from './abstractions/base_controller'

export default class UserController extends BaseController {
	public path = '/users'

	constructor() {
		super()
		this.initializeRoutes()
	}

	public initializeRoutes() {
		this.router.get(this.path, this.getUsers)
		this.router.get(this.path + '/:userId', this.getUserById)
	}

	getUsers = async (req: express.Request, res: express.Response) => {
		const users = await this.prisma.user.findMany()
		res.json({ code: 200, data: users })
	}

	getUserById = async (req: express.Request, res: express.Response) => {
		const user = await this.prisma.user.findUnique({
			where: { id: req.params.userId },
		})
		res.json({ code: 200, user })
	}

	getProfile = async (req: express.Request, res: express.Response) => {
		const tokens = req.headers.authorization?.split(' ')

		if (!tokens) {
			throw new HttpException(401, 'Unauthorized token!')
		}

		const [_, accessToken] = tokens
		const decodedToken = jwt.decode(accessToken) as JWTPayload

		const user = await this.prisma.user.findUnique({
			where: { id: decodedToken.sub },
		})

		res.json({ code: 200, data: user })
	}
}
