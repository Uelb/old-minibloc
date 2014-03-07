class ClientPhone < ActiveRecord::Base
  belongs_to :client
  belongs_to :phone
end
