class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    if user_params[:username] && !user_params[:password].empty?
      @user = User.new(user_params)

      if @user.save
        login(@user)
        redirect_to links_url, notice: 'User was successfully created.'
      else
        flash[:notice] = 'User could not be created.'
        render :new
      end
    else
      flash[:errors] = "Fields can't be left blank."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # def destroy
  #   @user.destroy
  #   redirect_to users_url, notice: 'User was successfully destroyed.'
  # end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
