class ProfilesController < ApplicationController
  #this includes the Helper functions
  include ProfilesHelper

  before_action :find_profile, only: [:show, :edit, :update, :update_profile, :edit_photos, :delete_photos, :flag, :has_visibility]
  before_action only: [:show, :edit, :update, :new] do
    has_visibility(@profile)
  end
  before_action only: [:edit, :update, :new] do
    allowed(@profile)
  end
  before_action :find_user, only: [:show, :edit, :update]
  before_action :interest_titles, only: [:show, :edit]
  before_action :get_pictures, only: [:show, :edit]
  
  
  def new
  end

  def create
    @profile = current_user.profile
    
    if @profile.update_attributes(profile_attributes)
      if params[:images]
        params[:images].each { |image|
          @profile.pictures.create(image: image)
        }
      end
      if @user.profile?
        @profile.set_interest_tags
        @profile.set_lat_and_lon
        redirect_to '/main', notice: "Profile was created!"
      end
    else
      flash[:notice] = @profile.errors #unless @profile.valid?
    end
  end

  # Work on -- Isnt really very DRY
  def show
      if current_user.blocks.where(profile_id: @profile.user_id).any?
         @disable = true
      end
      if current_user.profile_created == true
        create_visit
        @gender = @profile.gender_of
        @pref = @profile.sex_pref
        unless @profile.pictures.nil?
          @pictures = @profile.pictures 
        end
        unless @profile.postal_code.nil?
          @location = @profile.postal_code.to_region
          convert_postal_code(@profile)
        end
        unless @user.last_online.nil?
        puts @date_and_time = @user.last_online
        end
      end
  end

  def edit
    unless @profile.pictures.nil?
      @pictures = @profile.pictures
    end
  end

  
  def update
    # @profile = Profile.find_by(user_name: params[:user_name])
    if @profile.update_attributes(profile_params)
      @profile.set_interest_tags
      @profile.set_lat_and_lon
      redirect_to profile_path(@profile.user_name)
    else
      redirect_to edit_profile_path(@profile.user_name)
    end
  end

  def edit_photos
     
    p = params[:images]
    if params[:images]
      p.each { |image|
          puts image
          @profile.pictures.create(image: image)
      }
    end

    redirect_to edit_profile_path(@profile.user_name)
    # Work on -- could be a remote link to do a ajaxy thing of render the page again???
  end

  def delete_photo
    photo = Picture.find_by(id: params[:id])
    photo.destroy
    redirect_to edit_profile_path(current_user.user_name)
  end

  # Work on -- Ummm was it even using this?
  def update_profile
    @profile = Profile.find(params[:user_name])
  #   if @profile.update_attributes(profile_params)
  #     redirect_to settings_path(@profile.user_name)
  #   end
  end

  def flag 
    if @profile.is_flagged == false
      @profile.update_attribute(:is_flagged, true)
    end
    redirect_to profile_path(@profile.user_name)
  end
  
  private
  
    def find_user
      @user = User.find_by(user_name: params[:user_name])
    end

    def find_profile
      @profile = Profile.find_by(user_name: params[:user_name])
    end

    def create_visit
      unless @profile.user_id == current_user.id or current_user.profile.blocks.where(user_id: @profile.user_id).any?
        if @profile.visits.where(visitor_id: current_user.id).exists? == false
          a_visit = @profile.visits.where(visitor_id: current_user.id).create
          a_visit.create_activity key: 'visit.visited', owner: current_user, recipient: @user
        end
      end
    end

    def interest_titles
      @titles = @profile.interests.collect(&:name)
    end

    def get_pictures
      unless @profile.pictures.nil?
        @pictures = @profile.pictures
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
