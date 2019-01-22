class AddFlagToLanguage < ActiveRecord::Migration[5.2]
  def change
    add_column :languages, :flag, :string
    add_column :alphabets, :flag, :string
  end
end
