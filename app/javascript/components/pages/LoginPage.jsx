import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";

import TextInput from "../forms/TextInput";


class LoginPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = { form: {
      email: "test@test.com",
      password: "qwer",
    } };
  }
  headers = () => {
    const headers = new Headers();
    headers.append("Content-Type", "application/json");
    headers.append("X-Requested-With", "XMLHttpRequest");
    headers.append("X-CSRF-Token", this.props.csrfToken);
    return headers;
  };
  handleSubmit = (e) => {
    e.preventDefault();

    fetch("/login", {
      method: "POST",
      credentials: "include",
      headers: this.headers(),
      body: JSON.stringify(this.state.form),
    }).then((response) => {
      if (response.ok) {
        response.json().then((json) => {
          if (json.redirectTo) {
            window.location.assign(json.redirectTo);
          }
        });
      }
    });
  };
  handleInputUpdate = (k, v) => {
    this.setState({
      form: _.extend({}, this.state.form, { [k]: v }),
    });
  };
  render() {
    return (
      <span>
        <h1>Login</h1>
        <form onSubmit={ this.handleSubmit }>
          <label>Email: <TextInput name="email" type="email" onChange={ this.handleInputUpdate } value={ this.state.form.email } /></label>
          <label>Password: <TextInput name="password" type="password" onChange={ this.handleInputUpdate } value={ this.state.form.password } /></label>
          <input type="submit" value="Login" />
        </form>
      </span>
    );
  }
}

LoginPage.propTypes = {
  csrfToken: PropTypes.string.isRequired,
};

export default LoginPage;
