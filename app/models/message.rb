class Message < ActiveRecord::Base
	belongs_to :client
	belongs_to :main_message, class_name: "Message"
	belongs_to :status
	belongs_to :phone
	has_many :answers, class_name: "Message", foreign_key: :main_message_id
	validates_presence_of :recipient, :body
	scope :not_sent, -> { where(status_id: 211) }
end
