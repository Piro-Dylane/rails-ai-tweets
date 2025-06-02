class TweetsController < ApplicationController
  http_basic_authenticate_with name: "lewagon", password: ENV.fetch("BASIC_AUTH_PASSWORD", nil)
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(long: params[:tweet][:long])
    # Générer grâce à RubyLLM la version courte, la version tweet du tweet.long
    # chat = Ruby.chat
    response = RubyLLM.chat.ask("Please generate a tweet from this text: ```#{@tweet.long}```. \n\nMake sure that it is less than 280 characters")
    # response.content
    @tweet.shortened = response.content
    if @tweet.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end
end
