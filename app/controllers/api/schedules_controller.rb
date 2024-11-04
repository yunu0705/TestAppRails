module Api
  class SchedulesController < ApplicationController
    skip_before_action :verify_authenticity_token

    # 配信スケジュールの一覧を取得
    def index
      schedules = Schedule.where(user_id: params[:user_id]).order(:date)
    
      render json: {
        schedules: schedules
      }
    end
    

    # 配信スケジュールの作成
    def create
      @schedule = Schedule.new(schedule_params)
      if @schedule.save
        render json: @schedule, status: :created
      else
        render json: { error: @schedule.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # 配信スケジュールの更新
    def update
      @schedule = Schedule.find(params[:id])
      if @schedule.update(schedule_params)
        render json: @schedule
      else
        render json: { error: @schedule.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # 配信スケジュールの削除
    def destroy
      Rails.logger.debug "Received params: #{params.inspect}"
      schedule = Schedule.find_by(id: params[:id])
      if schedule&.destroy
        render json: { message: 'スケジュールを削除しました。' }, status: :ok
      else
        render json: { error: 'スケジュールの削除に失敗しました。' }, status: :unprocessable_entity
      end
    end

    private

    # ストロングパラメータの設定
    def schedule_params
      params.require(:schedule).permit(:date, :day_of_week, :time_range, :description, :user_id)
    end
  end
end
