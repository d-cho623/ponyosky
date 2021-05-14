class ApprovalsController < ApplicationController
  def create
    @approval = current_user.approvals.create(item_id: params[:item_id])
    redirect_to item_path(@approval.item_id) 
  end
  
  def destroy
    @approval = Approval.find_by(item_id: params[:item_id], user_id: current_user.id)
    @approval.destroy
    redirect_to item_path(@approval.item_id)
  end
end
