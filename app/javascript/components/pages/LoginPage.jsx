import React from 'react'

class LoginPage extends React.Component {
  onSubmit = (a, b) => {
    console.log(a, b);
    debugger;
  };
  render() {
    return (
      <span>
        <h1>Login</h1>
        <form onSubmit={ this.handleSubmit }>
          <label>Email: <input type="text" onClick={ this.onSubmit }/></label>
          <label>Password: <input type="password" /></label>
          <button type="submit" value="Login" onClick={ this.onSubmit }>Login</button>
        </form>
      </span>
    );
  }
}

export default LoginPage;
