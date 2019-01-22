class AddTextToMeaning < ActiveRecord::Migration[5.2]
  def change
    add_column :meanings, :text, :string
  end
end
