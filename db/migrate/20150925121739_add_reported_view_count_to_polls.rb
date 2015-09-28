class AddReportedViewCountToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :reported, :integer, default: 0, null: false
    add_column :polls, :view_count, :integer, default: 0, null: false
  end
end
