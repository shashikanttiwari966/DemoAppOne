ActiveAdmin.register Item do
  permit_params :name, :description, :amount, :currency
  menu false #parent: 'Rozarpay Payment', priority: 1

  action_item :only=>:index do
    render :partial => "form"
  end

  index do
    # content do
      panel "Item Lists" do
        render :partial => "index"
      end
    # end
  end

  controller do
    def index
      if params[:search].present?
        index! do |format|
        @items = Item.where("name ILIKE ?", params[:search]).page(params[:page])
          format.html
        end
      else
        super
      end
    end
  end
end
