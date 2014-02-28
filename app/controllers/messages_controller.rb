class MessagesController < ApplicationController
	before_filter :authenticate_client_with_token!, only: [:create, :show]
	before_filter :authenticate!, only: :index
	before_filter :authenticate_phone!, only: [:answer, :update]

	swagger_controller :messages, "Messages management"

	swagger_api :create do 
		summary "Send a new message, do not forget to save the returned id to be able to retrieve the message later"
		param :form, :recipient, :string, :required, "The recipient number of the message (0612345678)"
		param :form, :body, :string, :required, "The body of the message"
		param :form, :api_key, :string, :required, "The api key of the client doing the request"
	end

	swagger_api :show do 
		summary "Retrieve the information of a message"
		param :path, :id, :integer, :required, "The id of the message"
		param :form, :api_key, :string, :required, "The api key of the client doing the request"
	end

	swagger_api :answer do 
		summary "Inform that a message has been answered"
		param :form, 'message[:sender]', :string, :required, "The sender number of the message"
		param :form, 'message[:recipient]', :string, :optional, "The receiver number of the message"
		param :form, 'message[:body]', :string, :required, "The body of the message"
		param :form, :token, :string, :required, "The token of the phone doing the request" 
	end

	swagger_api :update do
		summary "Change the status code of a message"
		param :path, :id, :integer, :required, "the id of the message"
		param :form, 'message[:status_id]', :integer, :required, "The new status code of the message"
		param :form, :token, :string, :required, "The token of the phone doing the request" 
	end

	swagger_api :index do
		summary "A phone can retrieve messages to send and a client can see the messages he has sent"
		param :form, :api_key, :string, :optional, "The api key of the client doing the request"
		param :form, :token, :string, :optional, "The token of the phone doing the request" 
	end

	def create
		@m = Message.create create_message_params
		respond_to do |format|
      		format.html { redirect_to message_path(@m) and return}
      		format.json { render :json => @m }
    	end
	end

	def show
		@m = current_client.messages.where(id: params[:id]).first
		respond_to do |format|
      		format.html
      		format.json { render :json => @m }
    	end
	end

	def answer
		@phone = Phone.where(token: params[:token]).first
		@main_message = Message.where(:recipient => answer_message_params[:sender]).first
		return unless @main_message
		@message = Message.new answer_message_params
		@message.recipient = @phone.number
		@message.sent_at = DateTime.now
		@message.phone = @phone
		@message.main_message = @main_message
		@message.client = @main_message.client
		@message.status_id = 0
		@message.save
		respond_to do |format|
      		format.html { redirect_to message_path(@m) and return}
      		format.json { render :json => @message }
    	end
	end	

	def update
		@message = Message.where(id: params[:id]).first
		@message.update_attributes update_message_params
		@message.send_status_to_server
		respond_to do |format|
      		format.html { redirect_to message_path(@m) and return}
      		format.json { render :json => @message }
    	end
	end

	def index
		if current_client
			@messages = current_client.messages.order('created_at DESC')
		else #It's a phone asking
			@messages = Message.not_sent.first 25
		end
		respond_to do |format|
      		format.html { }
      		format.json { render :json => @messages }
    	end
	end

	private
	def create_message_params
		params.require(:message).permit(:recipient, :body)
	end

	def answer_message_params
		params.require(:message).permit(:recipient, :body, :sender)
	end

	def update_message_params
		params.require(:message).permit(:status_id)
	end
end
