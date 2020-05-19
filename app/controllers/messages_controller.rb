class MessagesController < ApplicationController
before_action :set_profile
  def index
    @messages = Message.where(thread_id: nil).where(["sender_id = ? OR recipient_id = ?", @profile.id, @profile.id])
  end

  def show
    message_threads = Message.where(thread_id: params[:id]).order(created_at: :asc)
    @messages = [Message.find(params[:id])]
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
