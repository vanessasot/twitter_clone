class TweetsController < ApplicationController
    def new
        @tweet = current_user.tweets.new()
    end
    
    def create
        @tweet = current_user.tweets.new(tweet_params)
        
        if @tweet.save
            redirect_to root_path, notice: 'Succesfully added'
        else
            render :new
        end
    end
    
    
    
    private
    
    def tweet_params
      params.require(:tweet).permit(:tweet)
    end
end
