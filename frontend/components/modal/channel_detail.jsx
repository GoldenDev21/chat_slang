import React from "react";
import { Link } from "react-router-dom";
import { merge } from "lodash";

class ChannelDetail extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      name: "",
      description: ""
    };
    this.setCurrentChannel = this.setCurrentChannel.bind(this);
  }

  update(field) {
    return e =>
      this.setState({
        [field]: e.currentTarget.value
      });
  }

  setCurrentChannel(channelId) {
    return e => {
      e.preventDefault();
      this.props.createSubscription({
        user_id: this.props.currentUser.id,
        subscribeable_id: channelId,
        subscribeable_type: "Channel"
      });
      this.props.requestCurrentChannel(channelId);
      this.props.closeModal();
    };
  }

  render() {
    const channels = this.props.channels.map((channel, idx) => {
      return (
        <li key={idx}>
          <button
            onClick={this.setCurrentChannel(channel.id)}
            className="conversation-li"
          >
            # {channel.name}
          </button>
        </li>
      );
    });

    return (
      <div className="modal-channel-container">
        <button className="x-button" onClick={this.props.closeModal}>
          {"\u24e7"}
        </button>
        <h1 className="channel_modal_title">Check out one of our Channels!</h1>
        <ul className="conversation-li">{channels}</ul>
      </div>
    );
  }
}

export default ChannelDetail;

//WILL EVENTUALLY BE FORM TO SEARCH FOR CHANNELS
// <form onSubmit={this.handleSubmit}>
//   <input
//     type="text"
//     value={this.state.name}
//     onChange={this.update("name")}
//     placeholder="#search for channel?"
//     className="signin-input-modal"
//   />
//   <button type="submit" className="new_channel_button_modal" />
// </form>