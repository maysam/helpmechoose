class CreateWordTags < ActiveRecord::Migration[5.2]
  def change
    create_table :word_tags do |t|
      t.references :word, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
