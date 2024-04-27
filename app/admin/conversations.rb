ActiveAdmin.register Conversation do
  menu priority: 3, label: "<i class='fas fa-comments'></i>Conversation".html_safe

  config.batch_actions = false
  config.paginate = false
  permit_params :admin_user_id, :friend_id

  collection_action :create_message, method: :post do
    @conversation = Conversation.find_by(id: params[:conversation_id])
    @message = @conversation.messages.create(admin_user_id: current_admin_user.id, receiver_id: params[:receiver_id], body: params[:body])
    # debugger
    ActionCable.server.broadcast "chats_channel", {
      conversation: @conversation, 
      message: @message, 
      current_user: current_admin_user,
      receiver_image: params[:receiver_image]
    }
    # ChatsChannel.broadcast_to(self.conversation, self)
    # redirect_to admin_conversations_path(conversation_id: conversation.id)
  end

  index :download_links => false, :paginate => false do
    div do
      render :partial => "conversation"
    end
  end

  form do |f|
    f.object.admin_user_id = current_admin_user.id
    f.inputs do
      input :friend_id, as: :select, :collection => AdminUser.where.not(id: current_admin_user.id).map{|user| [user.email, user.id]}, input_html:{ id:"selectElement"}
      input :admin_user_id#, input_html: {disabled: true}
    end
    f.actions
  end

  controller do
    def index
      index! do
        @conversations = get_conversation
        if params[:convertion_id].present?
          @conversation = @conversations.find_by(id: params[:convertion_id])
        else
          @conversation = @conversations.first
        end
        @conversations = @conversations.page(params[:page]).per(10)
      end
    end

    def create
      super
      debugger
    end

    private

    def get_conversation
      Conversation.where("admin_user_id = ? or friend_id=?", current_admin_user.id, current_admin_user.id)
    end
  end

  
end
