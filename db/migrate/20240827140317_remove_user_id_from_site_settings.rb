class RemoveUserIdFromSiteSettings < ActiveRecord::Migration[6.0]
  def change
    remove_column :site_settings, :user_id, :integer
  end
end
