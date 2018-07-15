class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :google_id
      t.string :locale
      t.string :name
      t.string :email
      t.string :picture
      t.string :given_name
      t.string :family_name
      t.boolean :email_verified

      t.timestamps
    end
  end
end
