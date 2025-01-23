import { Pool } from 'pg'



export class PgClient {
	private pool: Pool
	constructor(pool: Pool) {
		this.pool = pool
	}

	static async connect() {
		const pool = new Pool({
			// application_name
		})
		const client = await pool.connect()
		const res = await client.query("SELECT 1")
		console.log(res)
		client.release()
		return new PgClient(pool)
	}
}
