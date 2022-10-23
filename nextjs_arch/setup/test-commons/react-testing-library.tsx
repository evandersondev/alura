import {render as rtlRender} from '@testing-library/react'

function DefaultWrapper({children}){
  return children
}

export const customRender = (AllTheProviders = DefaultWrapper) => {
  return (ui, options = {}) =>
     rtlRender(ui, {wrapper: AllTheProviders,...options})

}

export * from '@testing-library/react'

export const render = () => console.error('Please create your own render method using customRender()')
