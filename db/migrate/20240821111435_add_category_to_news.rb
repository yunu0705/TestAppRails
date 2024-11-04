class AddCategoryToNews < ActiveRecord::Migration[7.1]
  def change
    add_column :news, :category, :string
  end
end
