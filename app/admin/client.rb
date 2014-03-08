ActiveAdmin.register Client do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :event_base_url, :name, :email
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  index do 
    selectable_column
    column :id
    column :email
    column :name
    column :api_key
    column :event_base_url
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :name
      f.input :event_base_url
    end
    f.actions
  end

end
