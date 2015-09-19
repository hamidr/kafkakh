class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :title, null: false
      t.integer :order, default: 0

      t.references :poll, index: true, null: false
    end
  end
end
