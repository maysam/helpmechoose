class Word < ApplicationRecord
  has_one_attached :picture
  has_many :meanings
  has_many :word_tags
  has_many :tags, through: :word_tags

  accepts_nested_attributes_for :word_tags, allow_destroy: true, reject_if: proc { |att| att['tag_id'].blank? }

  def to_s
    farsiAlphabet = Alphabet.find_by code: 'fa'
    farsiLanguage = Language.find_by code: 'fa'
    meaning = meanings.find_by language: farsiLanguage, alphabet: farsiAlphabet
    meaning ||= meanings.where.not(text: '').first || ''
  end

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
