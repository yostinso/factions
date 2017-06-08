import React from 'react';
import TextInput from '../forms/TextInput';
import _ from 'lodash';

class LoginPage extends React.Component {
  constructor(props) {
    super(props);
    this.state ={ form: {} };
  }
  handleSubmit = (a, b) => {
    console.log(a, b);
    debugger;
  };
  handleInputUpdate = (k, v) => {
    this.setState({ 
      form: _.extend({}, this.state.form, { [k]: v })
    });
  };
  render() {
    return (
      <span>
        <h1>Login</h1>
        <form onSubmit={ this.handleSubmit }>
          <label>Email: <TextInput name="email" onChange={ this.handleInputUpdate } /></label>
          <label>Password: <TextInput name="password" type="password" onChange={ this.handleInputUpdate } /></label>
          <button type="submit" value="Login">Login</button>
        </form>
      </span>
    );
  }
}

export default LoginPage;
