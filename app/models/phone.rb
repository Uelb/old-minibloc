class Phone < ActiveRecord::Base
	has_many :messages
	belongs_to :client
	has_many :client_phones
	has_many :clients_using_this_phone, through: :client_phones, source: :client
	before_create :generate_token
	before_create :generate_activation_code
	before_validation :ping
	after_create :send_activation_code

	def admin_activate
		client = Client.find 0
		save
	end

	def resend_activation_code
		send_activation_code
	end

	protected
		def generate_token
			self.token = loop do
			  token = SecureRandom.urlsafe_base64(nil, false)
			  break token unless Phone.exists?(token: token)
			end
		end

		def generate_activation_code
			self.activation_code= SecureRandom.urlsafe_base64(6, false)
		end

		def ping
			self.last_ping_date = Time.now
		end

		def send_activation_code
			Message.create recipient: self.number, body: "Votre code d'activation est le #{activation_code}.
      Veuillez répondre à ce message ou entrez ce code dans votre espace d'administration pour valider ce téléphone.",
			sender: "ADMIN", status_id: 210, client_id: 0
		end
end
