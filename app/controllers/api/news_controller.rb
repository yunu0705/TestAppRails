class Api::NewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    news = News.all.order(created_at: :desc)
  
    # 各ニュースに対してURLと画像URLを含める
    render json: news.map { |n| 
      n.as_json(only: [:id, :title, :date, :category, :url]) # urlも含める
        .merge(image_url: (url_for(n.image) if n.image.attached?))  # 画像がある場合にURLを追加
    }
  end
  
  def create
    news = News.new(news_params)
    
    if params[:image].present?
      news.image.attach(params[:image])
      puts "Image attached: #{news.image.attached?}"  # 画像が添付されたかどうかを確認
    else
      puts "No image attached"  # 画像が添付されていない場合
    end
  
    if news.save
      puts "News saved successfully"
      render json: { message: 'ニュースが投稿されました！' }, status: :created
    else
      puts "News save failed: #{news.errors.full_messages}"
      render json: { errors: news.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    news = News.find_by(id: params[:id])

    if news
      news.destroy
      render json: { message: 'ニュースが削除されました' }, status: :ok
    else
      render json: { error: 'ニュースが見つかりません' }, status: :not_found
    end
  end

  def update
    news = News.find_by(id: params[:id])

    if news
      news.update(news_params)
      news.image.attach(params[:image]) if params[:image].present?
      render json: { message: 'ニュースが更新されました！' }, status: :ok
    else
      render json: { error: 'ニュースが見つかりません' }, status: :not_found
    end
  end

  private

  def news_params
    params.require(:news).permit(:date, :title, :category, :image, :url)
  end  
end
