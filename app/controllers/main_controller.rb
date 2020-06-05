class MainController < ApplicationController
  include MainHelper
  

  
  before_action :get_user, only: [:get_location, :index, :update]
  # before_action :get_location, only: [:index]
  # actions for if the user has a profile 


  def index
    
    puts current_user.id

    if @user.profile_created == true
      #moved this here instead of being a before action due to the users who dont have a profile
      get_location

      @profile = current_user.profile
      @tags = @profile.interest_list

      @blocked_by_user = @user.blocks.pluck(:profile_id)
      # puts a = Profile.second.find_related_interests.to_a.pluck(:id)
      # @all = Profile.all_except(@user).ordered_by_rating.order_by_interests_in_common(@profile).order_by_distance(@profile)
      
      # @all_unordered = Profile.all_except(@user)
      @all = Profile.all_except(@user).order_by_rating.order_by_interests_in_common(@profile).order_by_distance(@profile)

      # Profile.all_except(@user).ordered_by_rating.where(id: @profile.find_related_interests.to_a.pluck(:id)) 
      # @all.where(id: a).order('id DESC')

      # @results = Geocoder.search(@location)
      @feed = suggestions(@all, @profile)
      
      
        
        

        #https://stackoverflow.com/questions/11265093/rails-dropdown-menu

        # https://makandracards.com/makandra/65468-rails-how-to-get-url-params-without-routing-parameters-or-vice-versa
        # https://stackoverflow.com/questions/34607721/merge-actioncontrollerparameters-with-rails-5
        # https://stackoverflow.com/questions/6916485/rails-appending-url-parameters-removing-url-parameters
       

        # This checks to see if there is any query parameters
        if request.query_parameters.any?
          # @params = params.slice(:sort, :per_page)
          @choices = request.query_parameters.slice(:sort_by, :gender, :age, :distance, :rating, :interests)
          if params[:interests]
            # p params[:interests]
            @interests = params[:interests].split("/")
          end
          # @choices helps to avoids XXS attacks
          @all = Profile.filter_profiles(current_user, request.query_parameters)
        else

            
        end


          

            
            #This checks to see if there is a sort, then it needs to determine the type of sort


            # Send to another method???
          
          # Then in here we apply logic and queries to the Profiles, based on the params 
         

        
    else
      # redirect_to profile_path(@user.user_name)
    end


      
    
  end


  # the hope would be to dymnaically update the results while choosing the options

  def create_multiple_params
    #https://stackoverflow.com/questions/30616529/how-to-accept-multiple-url-parameters-in-rails-with-the-same-key

  end
    
    
  def destroy_param
    # https://stackoverflow.com/questions/30616529/how-to-accept-multiple-url-parameters-in-rails-with-the-same-key

  end
  
  # def index
  #   if params["search"]
  #     @filter = params["search"]["flavors"].concat(params["search"]["strengths"]).flatten.reject(&:blank?)
  #     @cocktails = Cocktail.all.global_search("#{@filter}")
  #   else
  #     @cocktails = Cocktail.all
  #   end
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end  
  # end
  
  
  # if params[:filter][:young] and params[:filter][:old]
  #   @all = Profile.all_except(current_user).by_age_range(params[:filter][:young], params[:filter][:old]).order_by_age
  #   puts "yay1"
  # end
  
  # if params[:filter][:high] and params[:filter][:low]
  #   @all = Profile.all_except(current_user).by_rating_range(params[:filter][:low], params[:filter][:high])
  #   puts "yay2"
  # end

  # if params[:filter][:far] #and params[:filter][:far]

  #   @all = Profile.all_except(current_user).by_distance_range(params[:filter][:near], current_user.profile)
  #   puts "yay3"

  # end
  
  


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
