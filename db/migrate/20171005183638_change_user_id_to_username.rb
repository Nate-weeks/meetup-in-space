class ChangeUserIdToUsername < ActiveRecord::Migration
  def change
    rename_column(:user_meetups, :user_id, :username)
  end
end
