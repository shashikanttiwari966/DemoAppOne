ActiveAdmin.register Product do
  permit_params :sku, :name, :description, :weight, :price, :stock, images: []
  # permit_params do
  #   permitted = [:sku, :name, :description, :weight, :price, :stock, images: []]
  #   permitted << :other if params[:action] == 'create' && current_admin_user.admin?
  #   permitted
  # end
  filter :name

  index do
    selectable_column
    id_column
    column :sku
    column :name
    column :description
    column :weight do |product|
       "#{product.weight}g" if product.weight.present?
    end
    column :price
    column :stock
    column "images" do |product|
      if product.images.attached?
        product.images.each do |image|
          div do
            image_tag url_for(image), size: "80x50"
          end
        end
      end
    end
    # actions if current_admin_user.admin?
    actions do |product|
      link_to "Buy Now", order_products_path(product_id: product.id), class:"buy_now" unless current_admin_user.admin?
    end
  end

  form do |f|
    f.inputs do
      input :sku
      input :name
      input :description
      input :weight
      input :price
      input :stock
      input :images, as: :file, :input_html => {multiple: true}
    end
    f.actions
  end
end
