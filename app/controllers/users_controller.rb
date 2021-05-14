class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      render :show
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :uid, :occupation_id, :workplace_id, :group_id)
  end
    
end
