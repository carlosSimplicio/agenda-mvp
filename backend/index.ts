import express from "express"
import { RegisterDataModel, SignInDataModel } from "./src/models"
import { AuthenticationService } from "./src/authentication"
import { UserRepository } from "./src/repositories/user"
import { PgClient } from "./src/infra/postgres"
import { CompanyRepository } from "./src/repositories/company"


const app = express()
app.use(express.json())


const pgClient = new PgClient()
const companyRepository = new CompanyRepository(pgClient)
const userRepository = new UserRepository(pgClient)

app.post("/register", async (req, res) => {
	const data = RegisterDataModel.parse(req.body)
	console.log(data)
	const authService = new AuthenticationService(userRepository, companyRepository)
	await authService.register(data)
	res.end()
})

app.post("/signin", async (req, res) => {
	const data = SignInDataModel.parse(req.body)
	console.log(data)
	const authService = new AuthenticationService(userRepository, companyRepository)
	await authService.signIn(data)
	res.end()
})



app.listen(8080, async () => {
	const time = await pgClient.execute("select now();")
	console.log(`Server is up at ${time[0].now}`)
})
