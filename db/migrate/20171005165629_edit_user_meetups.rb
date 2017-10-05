class EditUserMeetups < ActiveRecord::Migration
  def change
    change_column(:user_meetups, :user_id, :string, null: false)
  end
end
