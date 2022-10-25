import UserApi, { IUser } from '../services/user'
import { GraphQLScalarType } from 'graphql'

interface MyContext {
  dataSources: {
    usersApi: UserApi
    getUser: UserApi
    createUser: UserApi
    updateUser: UserApi
    deleteUser: UserApi
  }
}

interface UserParams {
  id?: Number
  user: IUser
}

const resolvers = {
  RolesType: {
    ESTUDANTE: 'ESTUDANTE',
    DOCENTE: 'DOCENTE',
    COORDENACAO: 'COORDENACAO',
  },
  DateTime: new GraphQLScalarType({
    name: 'DateTime',
    description: 'string date and time format ISO-8601',
    serialize: (value: any) => new Date(value).toISOString(),
    parseValue: (value: any) => new Date(value),
    parseLiteral: (ast: any) => new Date(ast.value),
  }),
  Query: {
    users: async (_: any, __: any, { dataSources }: MyContext) => {
      return await dataSources.usersApi.getUsers()
    },
    user: async (
      _: any,
      { user: { id } }: UserParams,
      { dataSources }: MyContext,
    ) => {
      return await dataSources.usersApi.getUserById(id)
    },
  },
  Mutation: {
    createUser: async (
      _: any,
      { user }: UserParams,
      { dataSources }: MyContext,
    ) => {
      return await dataSources.usersApi.createUser(user)
    },
    updateUser: async (
      _: any,
      { id, user }: UserParams,
      { dataSources }: MyContext,
    ) => {
      return await dataSources.usersApi.updateUser(id!, user)
    },
    deleteUser: async (
      _: any,
      { id }: UserParams,
      { dataSources }: MyContext,
    ) => {
      return await dataSources.usersApi.deleteUser(id!)
    },
  },
}

export default resolvers
