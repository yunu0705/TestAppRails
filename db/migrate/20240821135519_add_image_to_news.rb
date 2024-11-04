class AddImageToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :image, :string
  end
end
