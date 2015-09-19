class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, null: false
      t.references :option, index: true, null: false
      t.references :poll, index: true, null: false

      t.timestamps null: false
    end

    add_index :votes, [:user_id, :poll_id], unique: true
  end
end
