class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @user = current_user
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:read_option] == "all"
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end

  @message = @conversation.messages.new
  end


  def new
    @message = @conversation.messages.new
  end


  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_messages_path(@conversation) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'messages/index'  }
        format.js  # <-- idem
      end
    end

    end

private
 def message_params
  params.require(:message).permit(:body, :user_id)
 end


end



