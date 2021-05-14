class ApprovalsController < ApplicationController
  def create
    # @approval = Approval.new(user_id: @current_user.id, item_id: params[:item_id])
    # if @approval.save
    #   redirect_to root_path
    # end
    # @item = Item.find_by(id: @item.item_id)
    # @approval_count = Approval.where(item_id: params[:item_id]).count

    @approval = current_user.approvals.create(item_id: params[:item_id])
    redirect_to item_path(@approval.item_id) 
  end
  
  def destroy
    # @approval = Approval.find_by(user_id: @current_user.id, item_id: params[:item_id])
    # @item = Item.find_by(id: @approval.item_id)
    # @approval.destroy
    # @approval_count = Approval.where(item_id: params[:item_id]).count

    @approval = Approval.find_by(item_id: params[:item_id], user_id: current_user.id)
    @approval.destroy
    redirect_to item_path(@approval.item_id) 
  end
end
