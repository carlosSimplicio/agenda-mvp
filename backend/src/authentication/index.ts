import { CreateUserData, RegisterData, SignInData } from "../models";
import { CompanyRepository } from "../repositories/company";
import { UserRepository } from "../repositories/user";
import bcrypt from "bcrypt"

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
		try {

			const companyId = await this.companyRepository.createCompany(transaction, registerData.companyName)
			console.log(companyId)
			const createUserData: CreateUserData = {
				...registerData, companyId
			}

			await this.userRepository.createUser(transaction, createUserData)

			await transaction.commit()
		} catch (err) {
			await transaction.rollback()
			throw err
		} finally {
			await transaction.release()
		}

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

	}


}

