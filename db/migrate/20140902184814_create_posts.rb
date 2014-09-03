class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :picture
      t.string :location
      t.datetime :release_date

      t.timestamps
    end
  end
end
