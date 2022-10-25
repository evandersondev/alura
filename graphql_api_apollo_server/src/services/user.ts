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
  customResponse

  constructor() {
    super()
    this.baseURL = 'http://localhost:3000/'
    this.customResponse = {
      code: 200,
      message: 'Operation completed successfully',
    }
  }

  async getUsers() {
    const users = await this.get<IUser[]>('users')

    return users.map(async user => {
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

    await this.post<IUser>('users', {
      ...user,
      id,
      role: role[0].id,
    })

    return {
      ...user,
      role: role[0],
    }
  }

  async updateUser(id: Number, user: IUser) {
    const role = await this.get<IRole[]>(`roles?type=${user.role}`)
    await this.put(`users/${id}`, {
      ...user,
      role: role[0].id,
    })

    return {
      ...this.customResponse,
      user: { ...user, role: role[0] },
    }
  }

  async deleteUser(id: Number) {
    await this.delete(`users/${id}`)
    return this.customResponse
  }
}

export default UserApi
