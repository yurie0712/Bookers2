class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path
    else
      render :edit
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def correct_user                                                              # 正しいユーザーかどうか確認
      @user = User.find(params[:id])                                            # URLのidの値と同じユーザーを@userに代入
      redirect_to(user_path(current_user)) unless @user == current_user         # @userと記憶トークンcookieに対応するユーザー(current_user)を比較して、失敗したらroot_urlへリダイレクト
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end