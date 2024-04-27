ActiveAdmin.register_page "AboutUs" do
  menu priority: 2, label: "<i class='fas fa-address-card'></i>AboutUs".html_safe
  content do
    panel "AboutUs" do
      div class: 'custom-class' do
        render partial: 'metrics/about_us'
      end
    end
  end
end