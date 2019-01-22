class Meaning < ApplicationRecord
  belongs_to :word
  belongs_to :language
  belongs_to :alphabet

  def to_s
    text
  end
end
