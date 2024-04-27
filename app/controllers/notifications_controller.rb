require "rqrcode"
class NotificationsController < ApplicationController
  def index
    @notifications = current_admin_user.notifications.order(created_at: :desc)
    render layout: false
  end

  def show
    @notification = Notification.find_by(id: params[:id])
    @notification.update(read_at: DateTime.now)
    qrcode = RQRCode::QRCode.new("
      Title: #{@notification.params[:message]},
      Plan / Product: #{@notification&.params[:params].present? ? @notification&.params[:params][0][:name] : nil},
      Amount: #{@notification&.params[:params].present? ? @notification&.params[:params][0][:price] : 0},
      Status: Paid
      ")
    @png = qrcode.as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: "black",
          file: nil,
          fill: "white",
          module_px_size: 10,
          resize_exactly_to: false,
          resize_gte_to: false,
          size: 200
        ).to_data_url
    if params[:format].present?
      respond_to do |format|
        format.html
        format.pdf do
            render pdf: "Invoice No. #{@notification.id}",
            page_size: 'A4',
            template: "notifications/show.html.erb",
            layout: "pdf.html",
            orientation: "Landscape",
            lowquality: true,
            zoom: 1,
            dpi: 75
        end
      end
    end
  end
end
