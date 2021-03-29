class FollowingsController < ApplicationController
    include UserScoped
  
    def index
      @users = @user.following.paginate(page: params[:page], per_page:10)
    end
  
  end