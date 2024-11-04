class Schedule < ApplicationRecord
  # バリデーションルールの設定
  validates :date, presence: true
  validates :day_of_week, presence: true
  validates :time_range, presence: true, unless: -> { description == '休み' } # 休みの場合はtime_rangeを必須にしない
  validates :description, presence: true

  # 保存前にtime_rangeのフォーマットを統一する
  before_save :format_time_range, unless: -> { description == '休み' } # 休みの場合はformat_time_rangeをスキップ

  # スコープの定義
  scope :past_schedules, -> { where('date < ?', Date.today.beginning_of_week) } # 今週の月曜日より前の日付のスケジュール
  scope :future_schedules, -> { where('date >= ?', Date.today.beginning_of_week) } # 今週の月曜日からの未来の日付のスケジュール

  private

  def format_time_range
    start_time, end_time = time_range.split("〜").map(&:strip)
    formatted_start_time = Time.parse(start_time).strftime('%H:%M')
    formatted_end_time = Time.parse(end_time).strftime('%H:%M')
    self.time_range = "#{formatted_start_time}〜#{formatted_end_time}"
  rescue
    errors.add(:time_range, "時間の形式が不正です")
    throw(:abort)
  end
end
