import express from "express"
import { RegisterDataModel } from "./src/models"


const app = express()
app.use(express.json())



app.post("/register", (req, res) => {
	const data = RegisterDataModel.parse(req.body)
	console.log(data)
	res.end()
})


app.listen(8080, () => {
	console.log("Server is up")
})
