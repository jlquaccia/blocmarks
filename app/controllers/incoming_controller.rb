class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # You put the message-splitting and business
    # magic here.
    @user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])
    @url = params["body-plain"]

    if @user.nil?
      @user = User.create(name: params[:sender], email: params[:sender], password: "helloworld", password_confirmation: "helloworld")
      @user.skip_confirmation!
      @user.save!
    end

    if @topic.nil?
      @topic = Topic.create(title: params[:subject], user_id: @user.id)
      @topic.save!
    end

    if @user && @topic && @url
      @bookmark = Bookmark.create(url: @url, topic_id: @topic.id)
      @bookmark.save!
    end

    # Assuming all went well.
    head 200
  end
end