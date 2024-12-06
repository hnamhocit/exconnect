import { PrismaClient } from '@prisma/client'
import express from 'express'

export abstract class BaseController {
	public router: express.Router
	public prisma: PrismaClient

	constructor() {
		this.prisma = new PrismaClient()
		this.router = express.Router()
	}

	public abstract initializeRoutes(): void
}
