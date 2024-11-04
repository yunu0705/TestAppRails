class AddUrlToNews < ActiveRecord::Migration[7.1]
  def change
    add_column :news, :url, :string
  end
end
