class AddTimeToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :start_time, :time
    add_column :posts, :end_time, :time
  end
end
