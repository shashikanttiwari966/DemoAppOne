class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    if @user.image.attached? 
      object = @user.image
      @filename = object.id.to_s + object.filename.extension_with_delimiter
      if ActiveStorage::Blob.service.respond_to?(:path_for)
        attachments.inline[@filename] = File.read(ActiveStorage::Blob.service.send(:path_for, object.key))
      elsif ActiveStorage::Blob.service.respond_to?(:download)
        attachments.inline[@filename] = object.image.download
      end
    end
    @password = params[:password]
    @url  = 'http://localhost:3000/admin/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
