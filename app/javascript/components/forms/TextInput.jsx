import React from 'react';
import PropTypes from 'prop-types';

class TextInput extends React.Component {
  handleChange = (e) => {
    if (this.props.onChange) {
      this.props.onChange(this.props.name, e.target.value);
    }
  };

  render() {
    return (
      <input type="text" onChange={ this.handleChange } />
    );
  }
}
TextInput.propTypes = {
  onChange: PropTypes.func,
  name: PropTypes.string.isRequired,
  type: PropTypes.oneOf(["text", "password"]),
};
TextInput.defaultProps = {
  type: "text",
};

export default TextInput;
