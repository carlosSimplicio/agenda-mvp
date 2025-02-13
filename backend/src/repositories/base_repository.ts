import { PgClient } from "../infra/postgres"

export default class BaseRepository {
	client: PgClient
	constructor(client: PgClient) {
		this.client = client
	}

	async getTransaction() {
		return this.client.getTransaction()
	}

}
