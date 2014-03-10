ActiveAdmin.register Message do

  index do
    selectable_column
    column :id
    column :recipient
    column :sender
    column :body
    column :sent_at
    column :status do |message|
      message.status.id.to_s + " - " + message.status.description
    end
    column :client
    column :retrieved_at
    column :received_at
    column :created_at
    default_actions
  end
  
end
