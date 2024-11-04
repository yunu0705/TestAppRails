class InquiryImage < ApplicationRecord
  self.table_name = "inquiries_images"  # 明示的にテーブルを指定
  has_one_attached :screenshot  # InquiryImageモデル用の添付ファイル設定
  validates :userName, :email, :content, presence: true
end
