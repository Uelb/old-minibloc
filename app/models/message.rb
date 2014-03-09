class Message < ActiveRecord::Base
	require "net/http"
	require "uri"
	belongs_to :client
	belongs_to :main_message, class_name: "Message"
	belongs_to :status
	belongs_to :phone
	has_many :answers, class_name: "Message", foreign_key: :main_message_id
	validates_presence_of :recipient, :body
	scope :not_sent, -> { where(status_id: Status.WAITING) }
	before_save :format_tel_number
	before_save :update_timestamps
	after_create :send_to_server_if_answer

	def format_tel_number
		Message.format_tel_number sender
		Message.format_tel_number recipient
	end

	def update_timestamps
		if status_id == Status.SENT
			sent_at = Time.now
		elsif status_id == Status.RECEIVED
			retrieved_at = Time.now
		end
	end

	def self.format_tel_number number
		number &&= number.gsub(/[ -]/,"").gsub("+33","0")
	end

	def send_to_server_if_answer
		if main_message
			client = main_message.client
			url = client.event_base_url.chomp("/") + "/answer"
			post url, main_message_id: main_message.id, sender: sender, body: body
		end
	end

	def send_status_to_server
		return unless client.event_base_url
		url = client.event_base_url.chomp("/") + "/status"
		post url, message_id: id, status: status_id
	end

	def post url, options={}
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data(options)
		response = http.request(request)
	end
end
