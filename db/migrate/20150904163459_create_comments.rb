class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title, null: false
      t.text :body
      t.references :user, index: true, null: false
      t.references :poll, index: true, null: false

      t.timestamps null: false
    end
  end
end
