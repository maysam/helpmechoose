class Tweet < ApplicationRecord
  has_one :child, class_name: 'Tweet', foreign_key: "parent_id"
  belongs_to :parent, class_name: 'Tweet', optional: true
  belongs_to :user
end
