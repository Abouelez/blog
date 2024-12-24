class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.bigint :user_id
      t.bigint :post_id

      t.timestamps
    end
  end
end
