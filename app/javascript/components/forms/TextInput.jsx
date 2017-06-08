import React from "react";
import PropTypes from "prop-types";

class TextInput extends React.Component {
  handleChange = (e) => {
    if (this.props.onChange) {
      this.props.onChange(this.props.name, e.target.value);
    }
  };

  render() {
    return (
      <input value={ this.props.value } type={ this.props.type } onChange={ this.handleChange } />
    );
  }
}
TextInput.propTypes = {
  onChange: PropTypes.func.isRequired,
  name: PropTypes.string.isRequired,
  value: PropTypes.string.isRequired,
  type: PropTypes.oneOf(["text", "password", "email"]),
};
TextInput.defaultProps = {
  type: "text",
};

export default TextInput;
