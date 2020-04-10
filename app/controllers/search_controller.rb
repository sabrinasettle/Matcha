class SearchController < ApplicationController
#   Needs to be searchable by these
#   A age gap.
#   A “fame rating” gap.
#   A location.
#   One or multiple interests tags.

# https://stackoverflow.com/questions/40264171/search-multiple-models-in-ruby-on-rails
# https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/

  def index
  end

  def new
    if params[:search].blank?  
      #alert doesnt work but the reroute does
      redirect_to('/', alert: "Empty field!") and return  
    else  
      # @parameter = params[:search].downcase  
      @results = User.all.where("lower(name) LIKE :search", search: @parameter)  
      # @results = User.search(params[:seach])
      # @results = User.search(search_term) + Profile.search(search_term) + Starter.search(search_term)

    end  
  end

  def search
  end

  private
    def user_params

      # {:book_rooms => [:checked_out]}
      # params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, {:profile => [:id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code]})
      params.require(:user).permit(:first_name, :last_name, :user_name, profile_attributes: [:age, :gender, :sexual_preferences])
    end
end
