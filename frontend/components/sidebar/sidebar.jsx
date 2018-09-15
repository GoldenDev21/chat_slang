import React from 'react';
import { Link } from 'react-router-dom';

class Sidebar extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
        <div className="sidebar-container">
          <h3 className='sidebar-title'>Slang Workspace</h3>
          <h6 className='sidebar-username'>{this.props.currentUser.username}</h6>
          <Link className='sidebar-username' to="/" onClick={this.props.signout}>Sign Out</Link>
        </div>
    );
  }
}

export default Sidebar;