import { gql } from 'apollo-server'

export default gql`
  scalar DateTime

  type User {
    id: ID!
    name: String!
    active: Boolean!
    email: String
    role: Role!
    createdAt: DateTime
  }

  enum RolesType {
    ESTUDANTE
    DOCENTE
    COORDENACAO
  }

  type Role {
    id: ID!
    type: RolesType!
  }

  type Query {
    users: [User]
    user(id: ID!): User
  }

  type Mutation {
    createUser(
      name: String!
      active: Boolean!
      email: String!
      role: RolesType!
      createdAt: DateTime
    ): User!
    updateUser(
      id: ID!
      name: String!
      active: Boolean!
      email: String!
      role: RolesType!
    ): User!
    deleteUser(id: ID!): ID!
  }
`
