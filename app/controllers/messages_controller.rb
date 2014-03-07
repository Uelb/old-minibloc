class MessagesController < ApplicationController
	before_filter :authenticate!, only: [:index, :show, :create]
	before_filter :authenticate_client!, only: [:new, :create]
	before_filter :authenticate_phone!, only: [:answers, :update]

	# swagger_controller :messages, "Messages management"

	# swagger_api :create do 
	# 	summary "Send a new message, do not forget to save the returned id to be able to retrieve the message later"
	# 	param :form, 'message[recipient]', :string, :required, "The recipient number of the message (0612345678)"
	# 	param :form, 'message[body]', :string, :required, "The body of the message"
	# end

	# swagger_api :show do 
	# 	summary "Retrieve the information of a message"
	# 	param :path, :id, :integer, :required, "The id of the message"
	# end

	# swagger_api :answers do 
	# 	summary "Inform that a message has been answered"
	# 	param :form, 'message[sender]', :string, :required, "The sender number of the message"
	# 	param :form, 'message[recipient]', :string, :optional, "The receiver number of the message"
	# 	param :form, 'message[body]', :string, :required, "The body of the message"
	# 	param :form, :token, :string, :required, "The token of the phone doing the request" 
	# end

	# swagger_api :update do
	# 	summary "Change the status code of a message"
	# 	param :path, :id, :integer, :required, "the id of the message"
	# 	param :form, 'message[status_id]', :integer, :required, "The new status code of the message"
	# 	param :form, :token, :string, :required, "The token of the phone doing the request" 
	# end

	# swagger_api :index do
	# 	summary "A phone can retrieve messages to send and a client can see the messages he has sent"
	# 	param :query, :token, :string, :optional, "The token of the phone doing the request" 
	# end

	def new
		@message = Message.new
	end

	def create
		@m = Message.new create_message_params
		@m.status_id = Status.WAITING
		@m.client = current_client
		@m.save
		if params[:api_key] || params[:token]
    	render :json => @m
    else
    	redirect_to message_path @m
    end
	end

	def show
		@message = current_client.messages.where(id: params[:id]).first
		if params[:api_key]
			render json: @message and return
		end
	end

	def answers
		@phone = Phone.where(token: params[:token]).first
		@main_message = Message.where(:recipient => Message.format_tel_number(answer_message_params[:sender])).first
		return unless @main_message
		@message = Message.new answer_message_params
		@message.recipient = @phone.number
		@message.sent_at = DateTime.now
		@message.phone = @phone
		@message.main_message = @main_message
		@message.client = @main_message.client
		@message.status_id = 0
		@message.save
  	render :json => @message
	end	

	def update
		@message = Message.where(id: params[:id]).first
		@message.update_attributes update_message_params
		@message.send_status_to_server
		render :json => @message
	end

	def index
		if current_client
			@client = current_client
			@messages = current_client.messages.order('created_at DESC')
		else #It's a phone asking
			phone = Phone.where(token: params[:token]).first
			if phone.client.id == 0
			else
			end
			@messages = Message.not_sent.first 25
			Message.update_all({status_id: Status.RETRIEVED, phone_id: Phone.where(token: params[:token]).first.id}, {id: @messages.map(&:id)})
		end
		if params[:token] || params[:api_key]
			render :json => @messages
		end			
	end

	private
	def create_message_params
		params.require(:message).permit(:recipient, :body, :status_id, :client)
	end

	def answer_message_params
		params.require(:message).permit(:recipient, :body, :sender)
	end

	def update_message_params
		params.require(:message).permit(:status_id)
	end
end
