class LandingController < ApplicationController
  skip_before_action :require_login

  def index
    if (current_user)
      redirect_to '/main'
    end
  end
end
