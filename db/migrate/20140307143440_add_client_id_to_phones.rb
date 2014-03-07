class AddClientIdToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :client_id, :integer
    add_index :phones, :client_id
  end
end
