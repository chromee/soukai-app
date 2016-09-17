class UsersController < ApplicationController
  include Common
  layout        :select_layout
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:index, :destroy]
  before_action :set_entrance_year, only: [:new, :edit]
  
  def index
    @users = User.paginate(page: params[:page])
    if params[:name] && params[:name].present?
      @users = @users.where(['name LIKE ?', "%#{params[:name]}%"])
    end
    @soukais = Soukai.narrow_year(Date.today.year).order("date")
  end
  
  def show
    @user = User.find(params[:id])
    @soukais = Soukai.narrow_year(Date.today.year).order("date")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "確認メールを送信しました。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "変更されました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
    private
      
      def set_entrance_year
        @entrance_years = (Date.today.year-10..Date.today.year).to_a
      end
end
