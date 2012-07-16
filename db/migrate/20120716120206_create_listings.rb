class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :title
      t.text :descr
      t.integer :approved
      t.string :url

      t.timestamps
    end
  end
end
