import config from "../config";
import { CreateUserData, RegisterData, SignInData } from "../models";
import { CompanyRepository } from "../repositories/company";
import { UserRepository } from "../repositories/user";
import bcrypt from "bcrypt"
import jwt from 'jsonwebtoken'

const SALT_ROUNDS = 10

export class AuthenticationService {
	private userRepository: UserRepository
	private companyRepository: CompanyRepository
	constructor(userRepository: UserRepository, companyRepository: CompanyRepository) {
		this.userRepository = userRepository
		this.companyRepository = companyRepository
	}

	async register(registerData: RegisterData) {
		console.log("Registering User")
		const user = await this.userRepository.getUser(registerData)

		if (user) {
			throw new Error("User already exists")
		}

		const hashedPassword = await bcrypt.hash(registerData.password, SALT_ROUNDS)

		registerData.password = hashedPassword
		console.log("userData hashed: ", registerData)

		const transaction = await this.companyRepository.getTransaction()
		await transaction.start()
		let companyId: number
		let userId: number
		try {

			companyId = await this.companyRepository.createCompany(transaction, registerData.companyName)
			console.log("Company created: ", companyId)
			const createUserData: CreateUserData = {
				...registerData, companyId
			}

			userId = await this.userRepository.createUser(transaction, createUserData)
			console.log("User created: ", userId)

			await transaction.commit()
		} catch (err) {
			await transaction.rollback()
			throw err
		} finally {
			await transaction.release()
		}

		const token = await this.generateToken({ userId, companyId })
		return token

	}

	async signIn(userData: SignInData) {
		console.log("Logging in User")
		const user = await this.userRepository.getUser(userData)

		if (!user) {
			throw new Error("User not found")
		}

		const passwordMatch = await bcrypt.compare(userData.password, user.password)
		console.log("password match: ", passwordMatch)
		if (!passwordMatch) {
			throw new Error("Incorrect password")
		}

		const token = await this.generateToken({ user })

		return token

	}

	private async generateToken(data: any) {
		let token = ""
		await new Promise((resolve, reject) => {
			jwt.sign({ data }, config.authorizationCookie.jwtSecret,
				(err: Error | null, generated_token: string | undefined) => {
					if (err) reject(err)

					if (!generated_token) reject(new Error("Failed to generate token"))

					token = generated_token ?? ""
					resolve(null)

				})
		})

		return token
	}


}

