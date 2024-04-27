ActiveAdmin.register User do
   menu priority: 10, label: "<i class='fas fa-users'></i> User".html_safe
  permit_params :email, :password, :first_name, :last_name, :status
  scope :pending, :default => true do |users|
    users.where(:status => 'pending')
  end
  scope :accepted, :default => true do |users|
    users.where(:status => 'accepted')
  end
  scope :rejected, :default => true do |users|
    users.where(:status => 'rejected')
  end

  index do
    selectable_column
    id_column
    column :email
    column :password
    column :first_name
    column :last_name
    column :status
    actions
  end

  controller do
    def update
      if params[:user][:status] == "accepted"
        AdminUser.create(email: resource.email, password: resource.password, password_confirmation: resource.password, role:"guest")
      end
      super
    end
  end
  
end
