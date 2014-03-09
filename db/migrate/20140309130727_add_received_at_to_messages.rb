class AddReceivedAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :received_at, :datetime
  end
end
