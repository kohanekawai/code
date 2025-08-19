class AddImageToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :image, :string
  end
end
