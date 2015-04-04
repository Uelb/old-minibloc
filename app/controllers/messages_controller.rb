class MessagesController < ApplicationController
	before_filter :authenticate!, only: [:index, :show, :create, :get_answers]
	before_filter :authenticate_client!, only: [:new, :create]
	before_filter :authenticate_phone!, only: [:answers, :update]
	layout 'macadmin'

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
    	redirect_to messages_path
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
		@message.phone = @phone
		@message.main_message = @main_message
		@message.client = @main_message.client
		@message.status_id = 0
		@message.save
  	render :json => @message
	end

	def get_answers
		@message = Message.where(id: params[:id]).first
		if @message
			render json: @message.answers
		else
			render nothing: true, status: 404
		end
	end

	def update
		@message = Message.where(id: params[:id]).first
		@message.status_id = update_message_params[:status_id]
		@message.save
		@message.send_status_to_server
		render :json => @message
	end

	def index
		if current_client
			@client = current_client
			@messages = current_client.messages.order('created_at DESC')
		else #It's a phone asking
			phone = Phone.includes(:client => :used_phones).where(token: params[:token]).first
			if phone.client && phone.client.id == 0
				@messages = phone.clients_using_this_phone.map(&:messages).map(&:not_sent).flatten.first 25
			elsif phone.client && phone.client.used_phones.include?(phone)
				@messages = phone.client.messages.not_sent.first 25 
			else
				render nothing: true, status: 404 and return 
			end
			Message.update_all({status_id: Status.RETRIEVED, phone_id: Phone.where(token: params[:token]).first.id, retrieved_at: Time.now}, {id: @messages.map(&:id)})
		end
		if params[:token] || params[:api_key]
			render :json => @messages
		end			
		if params[:no_layout]
			render layout: false
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
