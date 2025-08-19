class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.text :item
      t.text :point

      t.timestamps
    end
  end
end
