class ChangeDateColumn < ActiveRecord::Migration
  def change
    change_column :tasks, :date, :date
  end
end
