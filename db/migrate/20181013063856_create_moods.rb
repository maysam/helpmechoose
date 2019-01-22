class CreateMoods < ActiveRecord::Migration[5.2]
  def change
    create_table :moods do |t|
      t.references :user, foreign_key: true
      t.datetime :recorded_at
      t.string :client_id
      t.datetime :sent_at
      t.integer :status

      t.timestamps
    end
    add_index :moods, :recorded_at
    add_index :moods, :client_id
    add_index :moods, :status
  end
end
