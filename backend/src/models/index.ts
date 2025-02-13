import { z } from "zod";


export const RegisterDataModel = z.object({
	name: z.string().min(2, 'Name must have at least 2 characters'),
	email: z.string().email(),
	phone: z.string().min(11, 'Contact phone must have at least 11 characters'),
	companyName: z.string().min(2, 'Company Name must have at least 2 characters'),
	password: z.string().min(8, 'Password must have at least 8 characters'),
})


export type RegisterData = z.infer<typeof RegisterDataModel>

export const SignInDataModel = z.object({
	phone: z.string().min(11, 'Contact phone must have at least 11 characters'),
	password: z.string().min(8, 'Password must have at least 8 characters'),
})

export type SignInData = z.infer<typeof SignInDataModel>

export const CreateUserDataModel = RegisterDataModel.extend({
	companyId: z.number()
})

export type CreateUserData = z.infer<typeof CreateUserDataModel>
