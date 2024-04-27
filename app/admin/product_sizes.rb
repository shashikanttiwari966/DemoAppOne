ActiveAdmin.register ProductSize do

  permit_params :size, :product_type
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:size]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs do
      input :size
      input :product_type, as: :select, :collection => Product::PRODUCT_TYPE#, input_html: { class: 'inline-checkboxes' }, include_blank: false
    end
    f.actions
  end

  # controller do
  #   def create
  #     debugger
  #   end
  # end
end
