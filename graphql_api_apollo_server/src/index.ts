import { ApolloServer } from 'apollo-server'
import { DataSources } from 'apollo-server-core/dist/graphqlOptions'
import typeDefs from './graphql/schema'
import resolvers from './graphql/resolvers'
import UserApi from './services/user'

const app = new ApolloServer({
  typeDefs,
  resolvers,
  dataSources: () => ({
    usersApi: new UserApi(),
  }),
})

app.listen().then(({ url }) => console.log(`Server running on ${url}graphql`))
