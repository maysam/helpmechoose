class CreateMeanings < ActiveRecord::Migration[5.2]
  def change
    create_table :meanings do |t|
      t.references :word, foreign_key: true
      t.references :language, foreign_key: true
      t.references :alphabet, foreign_key: true

      t.timestamps
    end
  end
end
