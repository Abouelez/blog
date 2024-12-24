class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :tags
      t.string :user_id
      t.string :bigint

      t.timestamps
    end
  end
end
