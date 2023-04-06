# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      # span class: "blank_slate" do
      #   span I18n.t("active_admin.dashboard_welcome.welcome")
      #   small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
    end

    div class: "cart_item_count", id:"#{current_admin_user.cart.line_items.count}" do 
    end

    panel "Purches Product Charge", class:"charge-panel" do
      div class: 'custom-class' do
        @metric = Charge.all # whatever data you pass to chart
        render partial: 'metrics/partial_name', locals: {metric: @metric, toggel: "line_chart"}
      end
    end

    panel "Charges Amount On Pie Chart", class:"charge-panel" do
      div class: 'custom-class' do
        @metric = Charge.all # whatever data you pass to chart
        render partial: 'metrics/partial_name', locals: {metric: @metric, toggel: "pie_chart"}
      end
    end

    panel "Admin User Area Chart" do
      div class: 'custom-class-user' do
        # whatever data you pass to chart
        render partial: 'metrics/partial_name', locals: {toggel: ""}
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
