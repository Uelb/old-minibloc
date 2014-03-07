class Client < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :client_phones
  has_many :phones
  has_many :used_phones, through: :client_phones, source: :phone, before_add: :check_if_user_phone
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

  private
  def chek_if_user_phone(used_phone)
    raise "Not a user phone" if phones.exclude?(used_phone) && used_phone.client.id != 0
  end

end
