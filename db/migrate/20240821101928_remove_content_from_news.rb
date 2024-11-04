class RemoveContentFromNews < ActiveRecord::Migration[7.1]
  def change
    # カラムが存在する場合のみ削除する
    if column_exists?(:news, :content)
      remove_column :news, :content, :text
    end
  end
end
