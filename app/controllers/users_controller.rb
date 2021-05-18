class UsersController < ApplicationController

  def show
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      bypass_sign_in(@user) 
      render :show
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :uid, :occupation_id, :workplace_id, :group_id, :password, :password_confirmation)
  end
    
end
