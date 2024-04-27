ActiveAdmin.register Product do
  menu priority: 6, label: "<i class='fab fa-product-hunt'></i> Product".html_safe
  permit_params :sku, :name, :description, :weight, :price, :stock, :product_type, :category_id, :discount, images: [], product_colors_attributes:[:code, :_destroy, :id], product_sizings_attributes:[:product_size_id, :_destroy, :id]

  # menu parent: 'Stripe Payment', priority: 3
  # permit_params do
  #   permitted = [:sku, :name, :description, :weight, :price, :stock, images: []]
  #   permitted << :other if params[:action] == 'create' && current_admin_user.admin?
  #   permitted
  # end
  filter :name
  scope :all, default: true
  scope :cloths do |products|
    products.where(product_type:"Cloths")
  end
  scope :shoes do |products|
    products.where(product_type:"Shoes")
  end
  scope :Groceries do |products|
    products.where(product_type:"Grocery")
  end
  scope :Electronics do |products|
    products.where(product_type:"Electronics")
  end

  collection_action :get_product_size, method: :get do
    if params
      @product_size = ProductSize.where(product_type: params[:product_type]).map{|ps| [ps.id, ps.size]}
      render layout: false
    end
  end 

  index do
    if current_admin_user.admin?
      selectable_column
      id_column
      column :sku
      column :name
      # column :description
      column :weight do |product|
         "#{product.weight}g" if product.weight.present?
      end
      column :price
      column :stock
      column :discount
      column "images" do |product|
        if product.images.attached?
          product.images.map{|image|
              image_tag image, size: "80x50"
          }
        end
      end
      # actions if current_admin_user.admin?
      actions do |product|
        link_to "Buy Now", order_products_path(product_id: product.id), class:"buy_now" unless current_admin_user.admin?
      end
    else
      panel "Product Lists" do
        render :partial => "index"
      end
    end
  end

  form do |f|
    # f.object.product_type = Product::PRODUCT_TYPE.first
    f.inputs do
      input :sku
      input :name
      input :description
      input :weight
      input :price
      input :stock
      input :discount
      input :product_type, as: :select, :collection => Product::PRODUCT_TYPE, include_blank: false 
      input :category_id, as: :select, :collection => Category.all.map{|ca| [ca.name, ca.id]}, include_blank: false 
      input :images, as: :file, :input_html => {multiple: true}
      f.inputs do
        f.has_many :product_sizings, heading: 'Product Size', allow_destroy: true do |ps|
          ps.input :product_size_id, as: :select, :collection => ProductSize.where(product_type: f.object.product_type).map{|ps| [ps.size, ps.id]},include_blank: false 
        end
        f.has_many :product_colors, heading: 'Product Color', allow_destroy: true do |pc|
          pc.input :code, input_html: { type: "color",  style: "height: 50px;" }, include_blank: false 
        end
      end
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :sku
      row :name
      row :description
      row :weight
      row :price
      row :stock
      row :product_type
      row :category_id
      panel "Product Sizings" do
        table_for product.product_sizings do
          column :id
          column :product_size_id
        end
      end
      panel "Product Colors" do
        table_for product.product_colors do
          column :id
          column :code
        end
      end
      row "image" do |ad|
       if product.images.attached?
          product.images.map{|image|
              image_tag image, size: "80x50"
          }
        end
      end
    end
    active_admin_comments
  end
end
