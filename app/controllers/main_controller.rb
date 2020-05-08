class MainController < ApplicationController
  include MainHelper
  

  
  before_action :get_user, only: [:get_location, :index, :update]
  # before_action :get_location, only: [:index]
  # actions for if the user has a profile 


  def index
    # Logic for getting the ip address of a user 
    # only works if not on localhost using Geocoder
    # @location = request.location.city
    # @city = request.location.city

    #test locations
    # ip = request_ip
    # response = Geocoder.search(ip)
    
    puts current_user.id

    if @user.profile_created == true
      #moved this here instead of being a before action due to the users who dont have a profile
      get_location

      @profile = current_user.profile
      @tags = @profile.interest_list

      @blocked_by_user = @user.blocks.pluck(:profile_id)
      # puts a = Profile.second.find_related_interests.to_a.pluck(:id)
      # @all = Profile.all_except(@user).ordered_by_rating.order_by_interests_in_common(@profile).order_by_distance(@profile)
      
      @all_unordered = Profile.all_except(@user)
      @all = @all_unordered.order_by_rating.order_by_interests_in_common(@profile).order_by_distance(@profile)

      # Profile.all_except(@user).ordered_by_rating.where(id: @profile.find_related_interests.to_a.pluck(:id)) 
      # @all.where(id: a).order('id DESC')

      # @results = Geocoder.search(@location)
      @feed = suggestions(@all, @profile)
      
      # @data = params[:reorder_by] if params[:reorder_by]
      # puts @data
      # if params[:reorder_by]
      #   option = "rating ASC" if params[:reorder_by] == 'rating'
      #   option = "age ASC" if params[:reorder_by] == 'age'
      #   # @all = @all_unordered(:order => option)
      #   if params[:reorder_by] == 'age'
      #     @all = @all_unordered.order_by_age
      #   end
      # end
      # @people = Person.all(:order => option)
      # users_with_common_interests(@profile, @feed)
      
      # @activites = Profile.joins(:interests)
      # .group("interest.id")
      # .having("count(votes.id) > ?", params[:vote_count])
      # .order("created_at desc")
      

      @test = Profile.for_age_range(18, 90).order_by_age
    else
      # redirect_to profile_path(@user.user_name)
    end
    


    # if @user.profile_created == true
    #   # puts @feed = Profile.all_except(@user)
    #   if params["sort"]
    #     @filter = params["sort"]["gender"].flatten.reject(&:blank?)
    #     @feed = @feed.global_search("#{@filter}")
    #     # @feed = @filter.empty? ? Profile.all_except(@user) : Profile.all.tagged_with(@filter, any: true)
    #     puts @feed
    #   else
    #     @feed = Profile.all_except(@user)
    #   end
      #if profile.postal code is empty then use the lat/long of the user location
      # unless @profile.postal_code.nil?
      #   @location = @profile.postal_code.to_region
      #   # @user.change_lat_long(@profile)
      # end
      
      # puts @feed = Profile.includes(:user)

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

  def sort

  end

  def search #may not need
  end

  def update
    @all_unordered = Profile.all_except(@user)
    
    @data = params[:reorder_by]
    # @data = params[:reorder_by] if params[:reorder_by]
      puts @data
      if params[:reorder_by]
        # option = "user_rating DESC" if params[:reorder_by] == 'rating'
        # option = "age ASC" if params[:reorder_by] == 'age'

        # if params[:reorder_by] == 'age'
        #   @all = @all_unordered.order_by_age
        # end
        if params[:reorder_by] == 'rating'
          @all = @all_unordered.order_by_rating
        else 
          @all = @all_unordered
        end
        # @all = @all_unordered.order(option)
      end

    puts @data
  end

  


  # https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  # def filtering_params(params)
    # params.slice(:status, :location, :starts_with)
  # end
  private
    def get_user
      @user = current_user
    end

    def get_location

      # https://stackoverflow.com/questions/20827675/get-address-from-geocode-latitude-and-longitude
      # latitude = 40.0397
      # longitude = -76.30144
      # geo_localization = "#{latitude},#{longitude}"
      # query = Geocoder.search(geo_localization).first
      # query.address

      current_lat = @user.profile.postal_code.to_lat
      current_lon = @user.profile.postal_code.to_lon
      @origin = [current_lat, current_lon]
      # @location =
      
    end

end
