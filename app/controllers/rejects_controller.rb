class RejectsController < ApplicationController
  def create
    @reject = current_user.rejects.create(item_id: params[:item_id])
    redirect_to root_path
  end

  def destroy
    @reject = Reject.find_by(item_id: params[:item_id], user_id: current_user.id)
    @reject.destroy
    redirect_to root_path
  end
end
