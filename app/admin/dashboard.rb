# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard", class:"fas fa-edit" do
  menu priority: 1, label: "<i class='fas fa-home'></i>Dashboard".html_safe

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      # span class: "blank_slate" do
      #   span I18n.t("active_admin.dashboard_welcome.welcome")
      #   small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
    end

    div class: "cart_item_count", id:"#{current_admin_user.cart.line_items.count}" do 
    end
  end

  content do
    panel "Some Sort Details Of Plans & Products", style:"padding: 20px;" do
      columns do
        column do
          tabs do
            tab "Latest Plan Info(3)", class:"admin_tabs" do
              table_for Plan.last(3), { :sortable => true, :class => 'index_table'} do
                column :name
                column :duration
                column :price
                column :created_at
              end
            end
          
            tab "Latest Product Info(3)", class:"admin_tabs" do
              table_for Product.last(3), { :sortable => true, :class => 'index_table'} do
                column :name
                column :price
                column :stock
                column :created_at
              end
            end
          end
        end
      end
    end

    panel "Progress Chart Of Models", style:"text-align: center; padding: 20px;" do
      columns do
        column do
          panel "Purches Product Charge", style:"text-align: center;" do
            div do
              line_chart Charge.all.group_by_day(:created_at).count, download: true
            end
          end
        end

        column do
          panel "Count Charges Status", style:"text-align: center;" do
            div do
              pie_chart Charge.all.group(:status).count, download: true
            end
          end
        end

        column do
          panel "Admin User Created At Monthly", style:"text-align: center;" do
            div do
              line_chart AdminUser.all.group_by_month(:created_at).count, download: true
            end
          end
        end
      end
    end
  end
end
