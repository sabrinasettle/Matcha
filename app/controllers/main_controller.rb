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
      
      # @all_unordered = Profile.all_except(@user)
      @all = Profile.all_except(@user).order_by_rating.order_by_interests_in_common(@profile).order_by_distance(@profile)

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

      # request.params.merge()
        
        

        #https://stackoverflow.com/questions/11265093/rails-dropdown-menu

        # https://makandracards.com/makandra/65468-rails-how-to-get-url-params-without-routing-parameters-or-vice-versa
        # https://stackoverflow.com/questions/34607721/merge-actioncontrollerparameters-with-rails-5
        # https://stackoverflow.com/questions/6916485/rails-appending-url-parameters-removing-url-parameters
       

        # This checks to see if there is any query parameters
        if request.query_parameters.any?
          # @params = params.slice(:sort, :per_page)
          @choices = request.query_parameters.slice(:sort_by, :gender, :age, :distance, :rating, :interests)
          puts @choices.delete(:sort_by)
          if params[:interests]
            # p params[:interests]
            @interests = params[:interests].split("/")
            # Testing
            # @all = Profile.all_except(current_user).tagged_with(@interests, :any => true)
          end
          @all = Profile.filter_profiles(current_user, request.query_parameters)


          # @all = Profile.all_except(current_user).filter_profiles(@choices)
        else

            
        end


          

            
            #This checks to see if there is a sort, then it needs to determine the type of sort


            # Send to another method???
          
          # Then in here we apply logic and queries to the Profiles, based on the params 
         

        # params[:one].present?
        if params.empty?
            puts "YYYYYAAAAAAAAYYYYY"
        end

    else
      # redirect_to profile_path(@user.user_name)
    end


      
    
  end



  def update
    
    # case @data
    # when 'rating'
    #   @all = Profile.all_except(User.second).order_by_rating
    # when 'age'
    #   @all = Profile.all_except(User.second).order_by_age
    # when 'most'
    
    # when 'least'
    # end
    
    # if params[:by]
    #   if params[:filter]
    #     puts "I was filtered but then I ingnored it"
    #   end
    #   puts @data = params[:by]
    #   if params[:by] == 'rating'
    #     @all = @all.order_by_rating
    #   elsif params[:sort][:by] == 'age'
    #     #test
    #     @all = Profile.all_except(current_user).order_by_age
    #   elsif params[:by] == 'most'
    #     #test
    #     @all = Profile.all_except(current_user).order_by_interests_in_common(@user.profile)
    #   elsif params[:by] == 'least'
    #     # test the reverse bit for sure
    #     @all = Profile.all_except(current_user).order_by_interests_in_common(@user.profile).reverse
    #   elsif params[:by] == 'closest'
    #     #test
    #     @all = Profile.all_except(current_user).order_by_distance(@user.profile)
    #   elsif params[:by] == 'further'
    #     #test
    #     @all = Profile.all_except(current_user).order_by_distance(@user.profile).reverse_order
    #   end
    # end

    # closest
    # further
    # most
    # least
    
    # @data = params[:reorder_by]
    # # @data = params[:reorder_by] if params[:reorder_by]
    #   puts @data
    # if params[:reorder_by]
    # #     # option = "user_rating DESC" if params[:reorder_by] == 'rating'
    # #     # option = "age ASC" if params[:reorder_by] == 'age'

    #     if params[:reorder_by] == 'age'
    #       @all_unordered.order(age: :asc)
    #     # end
    # #     if @data == 'rating'
    # #       @all_unordered.order(user_rating: :desc)
    #     else 
    #       @all_unordered.order(:id)
    #     end
    # #     # @all = @all_unordered.order(option)
    # end

    # puts @data



    if params[:filter]
      list = params[:filter][:interest_tags]
      list.reject!(&:blank?)
      @all = Profile.all_except(current_user).by_age_range(params[:filter][:young], 
        params[:filter][:old]).by_rating_range(params[:filter][:low],
          params[:filter][:high]).by_distance_range(params[:filter][:far], current_user.profile)
      if list.length > 0 
        @all = @all.tagged_with(list, :any => true)
      end
      if params[:sort]
        puts "I am filtered and I tried sorting"
        puts "MAYBE THIS WILL WORK"
        puts params[:by]
      end
    end

    if params[:filter] and params[:sort]

      puts params[:filter]
      puts params[:sort]
      puts "heeeeeeeeeeeeeyyyyyyyyyyyyyy"
    end

    if params[:by]
      if params[:filter]
        puts "I was filtered but then I ingnored it"
      end
      # puts @data = params[:sort][:by]
      if params[:by] == 'rating'
        @all = @all.order_by_rating
      elsif params[:by] == 'age'
        @all = Profile.all_except(current_user).order_by_age
      elsif params[:by] == 'most'
        @all = Profile.all_except(current_user).order_by_interests_in_common(@user.profile)
      elsif params[:by] == 'least'
        # test the reverse bit for sure
        @all = Profile.all_except(current_user).order_by_interests_in_common(@user.profile).reverse
      elsif params[:by] == 'closest'
        #test
        @all = Profile.all_except(current_user).order_by_distance(@user.profile)
      elsif params[:by] == 'further'
        #test
        @all = Profile.all_except(current_user).order_by_distance(@user.profile).reverse_order
      end
    end

    respond_to do |format|
      format.js {}
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
