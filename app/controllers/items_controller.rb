class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :destroy, :update]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :user_condition, only: [:edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:maker, :name, :number, :code, :quantity, :price, :total_price, :trading_company, :retrieval, :image).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def user_condition
    unless @item.user.id == current_user.id || current_user.occupation_id == 6
      redirect_to root_path
    end
  end
end
