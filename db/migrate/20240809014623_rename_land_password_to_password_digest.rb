class RenameLandPasswordToPasswordDigest < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :land_password, :password_digest
  end
end
