class Phone < ActiveRecord::Base
	has_many :messages
	belongs_to :client
	before_create :generate_token
	before_create :generate_activation_code
	before_create :ping
	after_create :send_activation_code
	validates_uniqueness_of :token

	def ping
		last_ping_date = Time.now
	end

	def send_activation_code
		Message.create recipient: number, body: "Votre code d'activation est le #{activation_code}.
		Veuillez répondre à ce message ou entrez ce code dans votre espace d'administration pour valider ce téléphone.",
		sender: "ADMIN"
	end

	def admin_activate
		client = Client.find 0
		save
	end

	protected

	def generate_token
		self.token = loop do
		  random_token = SecureRandom.urlsafe_base64(nil, false)
		  break random_token unless Phone.exists?(token: random_token)
		end
	end

	def generate_activation_code
		self.activation_code = loop do
			activation_code = SecureRandom.urlsafe_base64(6, false)
		end
	end
end
