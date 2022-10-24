import { RESTDataSource } from 'apollo-datasource-rest'

enum RolesType {
  ESTUDANTE,
  DOCENTE,
  COORDENACAO,
}

interface IRole {
  id: Number
  type: RolesType
}

export interface IUser {
  id: Number
  name: string
  active: boolean
  email: string
  role: Number
}

class UserApi extends RESTDataSource {
  constructor() {
    super()
    this.baseURL = 'http://localhost:3000/'
  }

  async getUsers() {
    const users = await this.get<IUser[]>('users')

    return users.map(async (user: IUser) => {
      const role = await this.get<IRole>(`roles/${user.role}`)
      return {
        ...user,
        role,
      }
    })
  }

  async getUserById(id: Number) {
    const user = await this.get<IUser>(`users/${id}`)
    const role = await this.get<IRole>(`roles/${user.role}`)

    return {
      ...user,
      role,
    }
  }

  async createUser(user: IUser) {
    const users = await this.get<IUser[]>('users')
    const id = users.length + 1
    const role = await this.get<IRole[]>(`roles?type=${user.role}`)

    console.log(role[0].id)

    return this.post('users', {
      ...user,
      id,
      role: role[0].id,
    })
  }

  async updateUser(user: IUser) {
    const role = await this.get<IRole[]>(`roles?type=${user.role}`)

    return this.put(`users/${user.id}`, {
      ...user,
      role: role[0].id,
    })
  }

  async deleteUser(id: Number) {
    await this.delete(`users/${id}`)
    return id
  }
}

export default UserApi
