class MainController < ApplicationController
  include MainHelper
  
  before_action :get_user, only: [:get_location, :index]
  before_action :get_location, only: [:index]



  def index
    # Logic for getting the ip address of a user 
    # only works if not on localhost using Geocoder
    # @location = request.location.city
    # @city = request.location.city

    #test locations
    ip = request_ip
    response = Geocoder.search(ip)
    

    @profile = current_user.profile
    @tags = @profile.interest_list

    @blocked_by_user = @user.blocks.pluck(:profile_id)
    puts a = Profile.second.find_related_interests.to_a.pluck(:id)
    @all = Profile.all_except(@user).ordered_by_rating.order_by_interests_in_common(@profile)
  

    Profile.all_except(@user).ordered_by_rating.where(id: @profile.find_related_interests.to_a.pluck(:id)) 
    # @all.where(id: a).order('id DESC')

    @results = Geocoder.search(@location)
    # if @profile.str?
      # if @profile.female? and @profile.str?
        #  @feed = @all.male.straight
      # end
    # end
    @feed = suggestions(@all, @profile)
    # @feed = @all.male.straight
    puts @feed

    users_with_common_interests(@profile, @feed)
    
    # @activites = Profile.joins(:interests)
    # .group("interest.id")
    # .having("count(votes.id) > ?", params[:vote_count])
    # .order("created_at desc")
    

    @test = Profile.for_age_range(18, 90).order_by_age

    


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

  


  # https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  # def filtering_params(params)
    # params.slice(:status, :location, :starts_with)
  # end
  private
    def get_user
      @user = current_user
    end

    def get_location
      current_lat = @user.profile.postal_code.to_lat
      current_lon = @user.profile.postal_code.to_lon
      @origin = [current_lat, current_lon]
      # @location =
      
    end

end
