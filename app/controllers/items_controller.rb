class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path  
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:maker, :name, :number, :code, :quantity, :unit, :price, :total_price, :trading_company, :retrieval, :pdf).merge(user_id: current_user.id)
  end
end
