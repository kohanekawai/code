class TagMap < ApplicationRecord
  belongs_to :tweet
  belongs_to :tag

  validates :tweet_id, presence: true
  validates :tag_id, presence: true
end
