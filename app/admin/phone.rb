ActiveAdmin.register Phone do

  
  index do
    selectable_column
    column :number
    column :token
    column :last_ping_date do |phone|
      distance_of_time_in_words_to_now(phone.last_ping_date) rescue nil
    end
    column :created_at
    default_actions
  end
  
end
