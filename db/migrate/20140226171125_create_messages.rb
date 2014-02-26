class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :recipient, :null => false
      t.text :body, :null => false
      t.datetime :sent_at
      t.datetime :retrieved_at
      t.string :sender
      t.references :client
      t.references :main_message
      t.references :status
      t.references :phone

      t.timestamps
    end
  end
end
