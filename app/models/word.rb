class Word < ApplicationRecord
  has_one_attached :picture
  has_many :meanings

  def update_meanings(params)
    Alphabet.all.map do |alphabet|
      Language.all.map do |language|
        if text = params["Language#{language.code}Alphabet#{alphabet.code}"]
          meanings.find_or_create_by(alphabet: alphabet, language: language).update_attributes text: text
        end
      end
    end
  end
end
