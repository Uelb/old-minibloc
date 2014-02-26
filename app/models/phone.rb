class Phone < ActiveRecord::Base
	validates_presence_of :token
	has_many :messages
	before_create :generate_token
	before_create :ping


	def ping
		last_ping_date = DateTime.now
	end
	def ping!
		last_ping_date = DateTime.now
		save!
	end

	protected

	def generate_token
		self.token = loop do
		  random_token = SecureRandom.urlsafe_base64(nil, false)
		  break random_token unless Phone.exists?(token: random_token)
		end
	end
end
