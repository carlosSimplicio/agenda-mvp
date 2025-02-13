import { PgClient, Transaction } from "../infra/postgres";
import BaseRepository from "./base_repository";

export class CompanyRepository extends BaseRepository {
	constructor(client: PgClient) {
		super(client)
	}

	async createCompany(transaction: Transaction, companyName: string): Promise<number> {
		const query = "INSERT INTO company (name) VALUES ($1) returning id"
		const values = [companyName]

		const result = await transaction.execute(query, values)
		console.log(result)

		return result[0].id as number
	}

}
