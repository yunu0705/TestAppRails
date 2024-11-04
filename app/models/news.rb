class News < ApplicationRecord
  has_one_attached :image  # 画像添付機能を定義
end
