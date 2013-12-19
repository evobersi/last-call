class SearchController < ApplicationController
before_action :set_search, only: [:show, :edit, :update, :destroy]

  def search_products

    encoded = URI.encode(params[:search_id])
    response = HTTParty.get("http://api.shopstyle.com/api/v2/products?pid=uid6096-24223436-93&fts=#{encoded}&limit=100&sort=PriceLoHi&fl=d0&fl=d101")
    render json: response
  end

  def create
    binding.pry
    @search = Search.new(search_params)
    if @search.save
      render json: @search
    else
      render json: @search.errors, status: :unprocessable_entity
    end
  end

  def update
   if @search.update
      head :no_content
    else
      render json: @search.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_search
    @search = Search.find(params[:name])
  end  

  def search_params

  end
end
