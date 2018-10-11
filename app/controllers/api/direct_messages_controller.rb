class Api::DirectMessagesController < ApplicationController
  def index
    @direct_messages = current_user.direct_messages
    render :index
  end

  def create
    @direct_message = DirectMessage.new
    if @direct_message.save

      @subscription = Subscription.create(
        user_id: current_user.id,
        subscribeable_id: @direct_message.id,
        subscribeable_type: 'DirectMessage'
      )

      @other_subscription = Subscription.create(
        user_id: params[:userId],
        subscribeable_id: @direct_message.id,
        subscribeable_type: 'DirectMessage'
      )

      @pair1 = {
        direct_message: { id: @direct_message.id,
                          names: [@direct_message.users[0].username, @direct_message.users[1].username],
                          type: "Direct Message",
                          subs: @direct_message.subscriptions },
        subscription: @subscription
      }

      @pair2 = {
        direct_message: { id: @direct_message.id,
                          names: [@direct_message.users[0].username, @direct_message.users[1].username],
                          type: "Direct Message",
                          subs: @direct_message.subscriptions },
        subscription: @other_subscription
      }

      @pair1['socket_type'] = 'direct_message'
      @pair2['socket_type'] = 'direct_message'

      LineChannel.broadcast_to('line_channel', @pair1)
      LineChannel.broadcast_to('line_channel', @pair2)

      render :create
    else
      render json: ['invalid direct_message'], status: 401
    end
  end

  def show
    @direct_message = DirectMessage.find(params[:id])
  end

  def destroy
    @direct_message = DirectMessage.find(params[:id])
    Subscription.destroy(@direct_message.subscriptions[0].id)
    Subscription.destroy(@direct_message.subscriptions[1].id)
    @direct_message.destroy
    render :show
  end
end
