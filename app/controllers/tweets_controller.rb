class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

def index
  @tweets = Tweet.all 

  if params[:tag_ids].present?
    tweet_ids = []

    params[:tag_ids].each do |key, value|
      if value == "1"
        tag = Tag.find_by(tag_name: key)
        if tag.present?
          tag_tweets = tag.tweets
          @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
          tweet_ids.concat(tag_tweets.pluck(:id))
          puts key
        end
      end
    end

    tweet_ids = tweet_ids.uniq
    @tweets = @tweets.where(id: tweet_ids) if tweet_ids.present?
  end
end

  
 def new
    @tweet = Tweet.new
    @tweet = current_user.tweets.new
  end

   def show
    @tweet = Tweet.find(params[:id])  
 end

   
def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

 def search
    @tag_list = Tag.all               # こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  # クリックしたタグを取得
    @itirans = @tag.tweets.all        # クリックしたタグに紐付けられた投稿を全て表示
  end

  private
  def tweet_params
    params.require(:tweet).permit(:item, :point,:image, tag_ids: [])
  end


end
