import { gql } from 'apollo-server'

export default gql`
  scalar DateTime

  enum RolesType {
    ESTUDANTE
    DOCENTE
    COORDENACAO
  }

  type Role {
    id: ID!
    type: RolesType!
  }

  type User {
    id: ID!
    name: String!
    active: Boolean!
    email: String
    role: Role!
    createdAt: DateTime
  }

  input UserInput {
    name: String
    active: Boolean
    email: String
    role: RolesType
    createdAt: DateTime
  }

  type Query {
    users: [User]
    user(id: ID!): User
  }

  type Mutation {
    createUser(user: UserInput!): User!
    updateUser(id: ID!, user: UserInput!): updateUserResponse!
    deleteUser(id: ID!): deleteUserResponse!
  }

  interface CustomResponse {
    code: Int!
    message: String!
  }

  type deleteUserResponse implements CustomResponse {
    code: Int!
    message: String!
  }

  type updateUserResponse implements CustomResponse {
    code: Int!
    message: String!
    user: User!
  }
`
