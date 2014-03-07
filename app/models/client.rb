class Client < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :phones
  validates_presence_of :name


  def generate_api_key
	self.api_key = loop do
		random_api_key = SecureRandom.urlsafe_base64(nil, false)
		break random_api_key unless Client.exists?(api_key: random_api_key)
	end
	api_key
  end

  def generate_api_key!
  	generate_api_key
  	save!
  	api_key
  end

end
