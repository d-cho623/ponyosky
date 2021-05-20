class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :destroy, :update]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :user_condition, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
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
    @approval = Approval.new
    @reject = Reject.new
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
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

  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.uid = "guestuser_1"
      user.name = "ゲストユーザー"
      user.occupation_id = 2
      user.workplace_id = 2
      user.group_id = 2
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def new_guest2
    user = User.find_or_create_by(email: 'guest2@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.uid = "guestuser_2"
      user.name = "ゲスト課長"
      user.occupation_id = 5
      user.workplace_id = 2
      user.group_id = 2
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー(課長)としてログインしました。'
  end

  def new_guest3
    user = User.find_or_create_by(email: 'guest3@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.uid = "guestuser_3"
      user.name = "ゲスト発注グループ"
      user.occupation_id = 6
      user.workplace_id = 2
      user.group_id = 2
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー(発注グループ)としてログインしました。'
  end

  def new_guest4
    user = User.find_or_create_by(email: 'guest4@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.uid = "guestuser_4"
      user.name = "ゲスト受入グループ"
      user.occupation_id = 7
      user.workplace_id = 2
      user.group_id = 2
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー(受入グループ)としてログインしました。'
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
