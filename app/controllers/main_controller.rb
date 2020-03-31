class MainController < ApplicationController

  def index
    @user = current_user
    @feed = User.all
    if @user.profile_created == false
      puts @user.first_name
      # redirect_to create_profile_path(current_user.user_name)

      #https://www.sitepoint.com/build-curated-interest-feeds-in-rails/


      #https://stackoverflow.com/questions/21202371/how-to-make-a-pivot-table-on-ruby-on-rails
      # result = []
      # Order.all.group_by(&:name).each do |name, orders|
      #   record = {}
      #   record["name"] = name
      #   orders.each do |order|
      #     record[order.product_id] = order.amount
      #   end
      #   result.append(record)

      #geocoder
      # @matches = Profile.all.near(#current_user's location).order("created_at DESC")
          #nearbys function might be better
      # http://hankstoever.com/posts/11-Pro-Tips-for-Using-Geocoder-with-Rails
      # Model.near([location.latitude, location.longitude])

    end
  end

  def search #may not need
  end

  


  # https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  # def filtering_params(params)
    # params.slice(:status, :location, :starts_with)
  # end

end
