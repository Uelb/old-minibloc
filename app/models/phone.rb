class Phone < ActiveRecord::Base
	has_many :messages
	before_create :generate_token
	before_create :ping
	validates_uniqueness_of :token

	def ping
		last_ping_date = Time.now
	end

	protected

	def generate_token
		self.token = loop do
		  random_token = SecureRandom.urlsafe_base64(nil, false)
		  break random_token unless Phone.exists?(token: random_token)
		end
	end
end
