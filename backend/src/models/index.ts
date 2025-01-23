import { z } from "zod";


export const RegisterDataModel = z.object({
	name: z.string(),
	email: z.string(),
	phone: z.string(),
	companyName: z.string()
})


export type RegisterData = z.infer<typeof RegisterDataModel>



