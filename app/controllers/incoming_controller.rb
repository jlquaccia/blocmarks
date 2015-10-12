class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # You put the message-splitting and business
    # magic here.
    @user = User.find(params[:sender])
    @topic = Topic.find(params[:subject])
    @url = params["body-plain"] # ????????

    if @user == nil
      @user = User.new(params.require(:user).permit(:name))
      @user.save
    end

    if @topic == nil
      @topic = Topic.new(params.require(:topic).permit(:title))
      @topic.save
    end

    if @user && @topic
      @bookmark = Bookmark.new(params.require(:bookmark).permit(:url))
      @bookmark.save
    end

    # Assuming all went well.
    head 200
  end
end