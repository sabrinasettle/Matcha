class LandingController < ApplicationController
  def index
    if (current_user)
      redirect_to '/main'
    end
  end
end
