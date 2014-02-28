class Status < ActiveRecord::Base
	has_many :messages
	def self.SENT
	  80
	end
	def self.RECEIVED
		0
	end
	def self.RETRIEVED
		211
	end
	def self.WAITING
		210
	end
end
