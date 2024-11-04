class DropArticlesAndSiteSettings < ActiveRecord::Migration[6.0]
  def change
    drop_table :articles
    drop_table :site_settings
  end
end
