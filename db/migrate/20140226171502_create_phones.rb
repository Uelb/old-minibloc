class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.string :token, :null => false
      t.datetime :last_ping_date

      t.timestamps
    end
    add_index :phones, :token, :unique => true
  end
end
