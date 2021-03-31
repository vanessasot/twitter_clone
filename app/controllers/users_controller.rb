class UsersController < ApplicationController
    include UserScoped

    def show
       @tweets = @user.tweets.paginate(page: params[:page], per_page: 10)
    end

    def searching_for
        if params[:followed].present?
          @search_for = User.find_by(username: params[:followed])
          if @search_for != current_user
            if current_user.following.include?(@search_for)
              redirect_to tweets_path, alert: "User already followed."
            elsif !@search_for
              redirect_to tweets_path, alert: "Username does not exists."
            else
              follow = Relationship.create(follower: current_user, followed: @search_for)
              redirect_to user_path(@search_for.username), notice: "Your are now following #{@search_for.username}"
            end
          else
            redirect_to tweets_path, alert: "Invalid operation. You can't follow yourself."
          end
        end
      end
end
