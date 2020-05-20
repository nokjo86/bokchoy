class MessagesController < ApplicationController
before_action :set_profile
  def index
    ## Searches the messages table and selects record which doesn't contain parent_id (thread_id) & sender_id or recipient_id matches current user id.

    ## Load the associated user details to minimize queries (calling /finding individual profile > user > username) run for accessing username in the view. 

    @messages = Message.includes({sender: :user},{recipient: :user}).where(thread_id: nil).where(["sender_id = ? OR recipient_id = ?", @profile.id, @profile.id])
  end

  def show
    ## Searches the messages table and returns record contains parent_id (thread_id) in a specific order.
    message_threads = Message.where(thread_id: params[:id]).order(created_at: :asc)
    ## Find the original message (the parent)
    @messages = [Message.find(params[:id])]
    ## Add message and message threads if message thread is not nil
    @messages += message_threads unless message_threads == nil
  end

  def create
    first_msg = Message.find(msg_params[:thread_id])
    first_msg.sender_id == @profile.id ? rec_id = first_msg.recipient_id : rec_id = first_msg.sender_id
    Message.create(
      sender_id: @profile.id,
      recipient_id: rec_id,
      body: msg_params[:body],
      thread_id: msg_params[:thread_id]
    )

    redirect_to message_url(msg_params[:thread_id])
  end

  private
  
  def msg_params
    params.require(:message).permit(:body,:thread_id)
  end
end
