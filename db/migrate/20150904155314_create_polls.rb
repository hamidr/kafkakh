class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0
      t.string :tags, array: true, default: [], index: true

      t.references :user, index: true, null: false
      t.timestamps null: false
    end
  end
end
