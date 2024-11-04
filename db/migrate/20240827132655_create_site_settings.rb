class CreateSiteSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :site_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :background_color
      t.string :image

      t.timestamps
    end
  end
end
