class LikesController < ApplicationController
  before_action :find_profile

  def create
    @profile.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to '/main' }
      format.js
    end
    redirect_to profile_path(@profile.user_name)
  end

  def destory
    @profile.likes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html { redirect_to profile_path(@profile.user_name)}
      format.js
    end
    redirect_to profile_path(@profile.user_name)
  end

  private
    def find_profile
      @profile = Profile.find(params[:profile_id])
    end
end
