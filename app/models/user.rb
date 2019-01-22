class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :moods, dependent: :destroy

  def to_s
    if name
      name
    elsif given_name && family_name
      "#{given_name} #{family_name}"
    else
      email
    end
  end
end
