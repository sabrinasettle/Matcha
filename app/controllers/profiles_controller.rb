class ProfilesController < ApplicationController
  #this includes the Helper functions
  include ProfilesHelper

  before_action :find_user, only: [:show, :edit, :update]
  before_action :find_profile, only: [:show, :edit, :update, :update_profile]
  before_action :interest_titles, only: [:show, :edit]
  before_action :find_likes, only: [:edit]
  before_action :find_visitors, only: [:edit]
  before_action :find_matches, only: [:edit]
  # before_action :profile_params, only: [:create]
  
  
  def show
    if current_user.profile_created == true
      create_visit
      @partner = looking_for(@profile)

      unless @profile.pictures.nil?
        @pictures = @profile.pictures 
      end

      unless @profile.postal_code.nil?
        @location = @profile.postal_code.to_region
        # @user.change_lat_long(@profile)
      end

      # respond_to do |format|
        # format.html { render(:text => "not implemented") }
        # format.js {}
      # end
    end

  end

  def edit
    unless @profile.pictures.nil?
      @pictures = @profile.pictures 
    end
  
    @flag = params[:flag]
    respond_to do |format|
      format.html {}
      case
      when @flag == '1'
        format.js { render :editprofile, layout: false}
      when @flag == '2'
        format.js { render :editphotos, layout: false}
      end
    end
  end

  
  def update
    # @user = User.find(params[:username])
    # @profile = Profile.find_by(user_name: params[:user_name])
    # puts @user.user_name
    # puts @profile.user_name
    # if @profile.update_attributes(profile_params)
      # redirect_to edit_profile_path(@profile.user_name)
    # elsif @user.update_attributes(user_params) 
      # redirect_to edit_profile_path(@user.user_name)
    # end
    # @user.update_attributes(user_params) 
    # @user.update(user_params)
    # if @profile.update(profile_params)
      # puts @profile.age
    # end
    # if @user.update_attributes(user_params)
      # redirect_to '/'
    # end
    # if @profile.update_attributes(profile_params)
      # puts @user.user_name
    # end
    # if @profile.update(user_params)
      # puts @profile.user_name
    # end
    # if @user.update_attributes(user_params)
      # unless @profile.postal_code.nil?
        # @user.change_lat_long(@profile)
      # end
      #  redirect_to '/login' #redirect back to the profile or rerender the page??
    # end
    # if @profile.update_attributes(profile_params)
      # redirect_to '/main'
      # redirect_to '/login' #redirect back to the profile or rerender the page??
    # end
  end

  def update_profile
    @profile = Profile.find(params[:user_name])
    if @profile.update_attributes(profile_params)
      redirect_to settings_path(@profile.user_name)
    end
  end

  def new
  end

  def create
    # @user = current_user
    #this worked
    # @profile = Profile.create!(profile_params)
    # @profile = Profile.new(profile_params)
    #I hand the one below before and that worked
    # @profile = @user.profile
    @profile = current_user.profile
    if @profile.update_attributes(profile_attributes)
    # if @profile.save
      if params[:images]
        params[:images].each { |image|
          @profile.pictures.create(image: image)
        }
      end
      if @user.profile?
        redirect_to '/main', notice: "Profile was created!"
      end
    else

    end
  end
  
  private
  
    def find_user
      @user = User.find_by(user_name: params[:user_name])
    end

    def find_profile
      @profile = Profile.find_by(user_name: params[:user_name])
    end

    def create_visit
      #added in because I think I needed it, havent tested tho
      unless @profile.user_id == current_user.id
        @profile.visits.where(visitor: current_user).first_or_create
      end
    end

    def interest_titles
      @titles = @profile.interests.collect(&:name)
    end

    def find_likes
      unless @profile.likes.nil?
        @liker_ids = @profile.likes.pluck(:user_id)
        @likers_names = User.where(id: @liker_ids).collect { |p| p.user_name }
      end
    end

    def find_visitors
      unless @profile.visits.nil?
        ids = @profile.visits.order(created_at: :desc).pluck(:visitor_id)
        @visitors = User.where(id: ids).collect { |p| p.user_name }
      end
    end

    def find_matches
      unless @profile.likes.nil?
        ids = @profile.likes.where(profile_id: [@profile.id], user_id: [@liker_ids]).pluck(:user_id)
        @matches_names = Profile.where(user_id: ids)
      end
      
    end

    def profile_params
      #how to array
      # params[:post].permit(:subject, :body, :author_ids => [])
      params.require(:profile).permit(:user_id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code, interest_ids:[])
    end

    def user_params

      # {:book_rooms => [:checked_out]}
      # params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, {:profile => [:id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code]})
      params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, profile_attributes: [:id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code])
    end
 
end
