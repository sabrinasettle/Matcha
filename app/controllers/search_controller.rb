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
    if params[:term]
      @feed = Profile.user_search(params[:term])
    else
      @feed = Profile.all
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
