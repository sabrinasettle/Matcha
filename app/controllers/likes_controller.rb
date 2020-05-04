class LikesController < ApplicationController
  include LikesHelper

  before_action :find_profile
  before_action :find_user

  def create
    @profile.likes.create(user_id: current_user.id)
    a_like = @profile.likes.last
    a_like.create_activity key: 'like.liked', owner: current_user, recipient: @user

    if match?(@profile)
      create_match(@profile)
    end
    respond_to do |format|
      format.html 
      format.js { redirect_to profile_path(@profile.user_name)}
    end
    
  end

  def destory
    if match?(@profile)
      destroy_match(@profile)
    end
    @profile.likes.where(user_id: current_user.id).destroy_all
  
    respond_to do |format|
      format.html 
      format.js { redirect_to profile_path(@profile.user_name)}
    end
  end

  private
    def find_user
      @user = User.find_by(id: params[:profile_id])
    end

    def find_profile
      @profile = Profile.find(params[:profile_id])
    end
end
