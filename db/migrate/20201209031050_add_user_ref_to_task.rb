class AddUserRefToTask < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, null: false, default: 1, index: true, foreign_key: true
  end
end
