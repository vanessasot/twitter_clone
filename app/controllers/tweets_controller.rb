class TweetsController < ApplicationController
    before_action :set_tweet, only: [ :show, :edit, :update, :destroy ]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        if user_signed_in?
          @tweets = Tweet.where(user_id: current_user.following).or(Tweet.where(user_id: current_user)).paginate(page: params[:page], per_page: 10)
        else
          @tweets = Tweet.all.paginate(page: params[:page], per_page: 10)
        end
        @tweet = Tweet.new
        @users = User.all
        @user = current_user
    end

    def show
    end

    def new
        @tweet = current_user.tweets.build
    end

    def edit
    end
    
    def create
        @tweet = current_user.tweets.build(tweet_params)
        
        respond_to do |format|
            if @tweet.save
                format.html { redirect_to tweets_path(@tweet), notice: "Tweet was successfully created." }
                format.json { render :show, status: :created, location: tweets_path(@tweet) }
              else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @tweet.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def update
        respond_to do |format|
          if @tweet.update(tweet_params)
            format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
            format.json { render :show, status: :ok, location: @tweet }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @tweet.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def destroy
        @tweet.destroy
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Tweet was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    
    private
    
    def set_tweet
        @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:tweet)
    end
end
