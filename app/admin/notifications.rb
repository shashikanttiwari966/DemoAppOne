ActiveAdmin.register Notification do
  menu false
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :recipient_type, :recipient_id, :type, :params, :read_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:recipient_type, :recipient_id, :type, :params, :read_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
