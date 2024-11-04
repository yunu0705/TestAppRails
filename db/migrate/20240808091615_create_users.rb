class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :landAccount_name
      t.string :landEmail_address
      t.string :land_password

      t.timestamps
    end
  end
end
