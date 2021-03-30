class FollowersController < ApplicationController
    include UserScoped
  
    def index
      @followers_pagi = @user.followers.paginate(page: params[:page], per_page:10)
    end
  
  end