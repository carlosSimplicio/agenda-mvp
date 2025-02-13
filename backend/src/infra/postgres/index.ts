import { Pool, PoolClient, QueryArrayResult, QueryResult, QueryResultRow } from "pg";

export class PgClient {
	private pool: Pool
	constructor() {
		this.pool = new Pool({
			host: "localhost",
			user: "root",
			password: "12345",
			max: 10,
			connectionTimeoutMillis: 5000,
			idleTimeoutMillis: 10000
		})

	}

	async execute(query: string, values?: any[]) {
		const result = await this.pool.query(query, values)

		return result.rows
	}

	async getTransaction() {
		const client = await this.pool.connect()

		return new Transaction(client)
	}
}

export class Transaction {
	client: PoolClient
	timeout: NodeJS.Timeout
	lastQuery?: any
	constructor(client: PoolClient) {
		this.client = client
		this.timeout = setTimeout(() => {
			console.error('A transaction has been checked out for more than 5 seconds!')
			console.error(`The last executed query on this transaction was: ${JSON.stringify(this.lastQuery)}`)
		}, 5000)
	}


	async execute(query: string, values?: any[]) {
		this.lastQuery = { query, values }
		const result = await this.client.query(query, values)

		return result.rows
	}

	async start() {
		return this.client.query("BEGIN;")

	}

	async commit() {
		return this.client.query("COMMIT;")
	}

	async rollback() {
		return this.client.query("ROLLBACK;")
	}

	async release() {
		clearTimeout(this.timeout)
		return this.client.release()
	}
}

