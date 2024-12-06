import { hash, verify } from 'argon2'
import express from 'express'
import jwt from 'jsonwebtoken'

import { JWTPayload } from '../types/payload'
import { BaseController } from './abstractions/base_controller'

export default class AuthController extends BaseController {
	public path = '/auth'

	constructor() {
		super()
		this.initializeRoutes()
	}

	public initializeRoutes(): void {
		this.router.post(this.path + '/login', this.login)
		this.router.post(this.path + '/register', this.register)
		this.router.post(this.path + '/logout', this.logout)
	}

	login = async (req: express.Request, res: express.Response) => {
		const data = req.body

		if (!data.email || !data.password) {
			res.json({ error: { code: 400, message: 'Invalid credentials!' } })
			return
		}

		const existingUser = await this.prisma.user.findUnique({
			where: { email: data.email },
		})

		if (!existingUser) {
			res.json({ error: { code: 404, message: 'User not found!' } })
			return
		}

		const pwMatches = await verify(existingUser.password, data.password)

		if (!pwMatches) {
			res.json({
				error: { code: 401, message: 'Password is incorrect!' },
			})
			return
		}

		const payload = { sub: existingUser.id, email: existingUser.email }
		const tokens = this.generateTokens(payload)

		await this.updateRefreshToken(existingUser.id, tokens.refreshToken)

		res.json({ code: 200, data: tokens })
	}

	register = async (req: express.Request, res: express.Response) => {
		const data = req.body

		if (!data.email || !data.password) {
			res.json({ error: { code: 400, message: 'Invalid credentials!' } })
			return
		}

		const existingUser = await this.prisma.user.findUnique({
			where: { email: data.email },
		})

		if (existingUser) {
			res.json({ error: { code: 400, message: 'Email already in use!' } })
			return
		}

		const hashedPassword = await hash(data.password)
		const newUser = await this.prisma.user.create({
			data: { ...data, password: hashedPassword },
		})

		const payload = { sub: newUser.id, email: newUser.email }
		const tokens = this.generateTokens(payload)

		await this.updateRefreshToken(newUser.id, tokens.refreshToken)

		res.json({ code: 201, data: tokens })
	}

	logout = async (req: express.Request, res: express.Response) => {
		const tokens = req.headers.authorization?.split(' ')

		if (!tokens) {
			res.json({ error: { code: 401, message: 'Unauthorized token!' } })
			return
		}

		const [_, accessToken] = tokens
		const decodedToken = jwt.decode(accessToken) as JWTPayload

		await this.updateRefreshToken(decodedToken.sub)

		res.json({ code: 200, data: 'OK' })
	}

	private async updateRefreshToken(id: string, refreshToken?: string) {
		await this.prisma.user.update({
			where: { id },
			data: {
				refreshToken: refreshToken ? await hash(refreshToken) : null,
			},
		})
	}

	private generateTokens(payload: JWTPayload) {
		const tokens = {
			accessToken: jwt.sign(
				payload,
				process.env.JWT_ACCESS_TOKEN as string,
				{
					expiresIn: process.env.JWT_ACCESS_EXPIRESIN,
				}
			),
			refreshToken: jwt.sign(
				payload,
				process.env.JWT_REFRESH_TOKEN as string,
				{
					expiresIn: process.env.JWT_REFRESH_EXPIRESIN,
				}
			),
		}
		return tokens
	}
}
