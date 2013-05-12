class TweetsController < ApplicationController
  def index
  	@tweet = Tweet.new
  	@tweets = Tweet.all
  end

  def show
    @tweet = Tweet.new
    @tweets = Tweet.all
  end
  def new
  	@tweet = Tweet.new
  end

  def create
  	@tweet = current_user.tweets.new(params[:tweet])
    if @tweet.save
      respond_to do |format|
        format.html { redirect_to tweets_url, notice: 'tweet was created' }
      end
    else
      respond_to do |format|
        format.html { render @tweet.errors }
      end      
    end
  end
end
