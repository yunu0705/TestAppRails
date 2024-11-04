class CreateInquiriesImages < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries_images do |t|
      t.string :userName
      t.string :email
      t.text :content
      t.string :inquiryType

      t.timestamps
    end
  end
end
