ActiveAdmin.register Order do
  menu priority: 5, label: "<i class='fab fa-first-order'></i> Order".html_safe
  permit_params :product_id, :admin_user_id, :status, :payment_mode, :expected_delivery, :order_track_id, :address, :pin_code
  
end
