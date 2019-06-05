class HomeController < ApplicationController
  require 'open-uri'

  def top
    respond_to do |format|
      format.html { render 'top'}
      format.js {
        # 検索ボックスの中身を受け取る
        @query = params[:query]

        # オートコンプリートAPIを呼び出す
        key = ENV['GOOGLE_PLACES_API_KEY']
        url = URI.encode "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=#{@query}&language=ja&key=#{key}"
        response = JSON.load(open url)

        # レスポンスから店名と住所を抜き出して、配列に整形
        @descriptions = response["predictions"].map{ |prediction| prediction["description"] }
        render 'top' }
    end
  end
end
