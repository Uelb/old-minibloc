class CreateClientPhones < ActiveRecord::Migration
  def change
    create_table :client_phones do |t|
      t.references :client, index: true
      t.references :phone, index: true
      t.boolean :available, default: true, null: false

      t.timestamps
    end
  end
end
