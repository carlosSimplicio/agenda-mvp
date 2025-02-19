import { PgClient, Transaction } from "../infra/postgres";
import { CreateUserData, SignInData } from "../models";
import BaseRepository from "./base_repository";

export class UserRepository extends BaseRepository {
	constructor(client: PgClient) {
		super(client)
	}

	async createUser(transaction: Transaction, userData: CreateUserData) {
		const query = "insert into users (name, password, email, phonenumber, companyid) values($1, $2, $3, $4, $5) returning id"
		const values = [userData.name, userData.password, userData.email, userData.phone, userData.companyId]
		const result = await transaction.execute(query, values)

		return result[0].id as number
	}

	async getUser(userData: SignInData) {
		const query = "select id, name, password, email, phonenumber, companyid from users where phonenumber = $1"
		const values = [userData.phone]

		const result = await this.client.execute(query, values)

		return result[0]
	}

}
