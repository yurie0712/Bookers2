class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:edit, :update]

  def index
    @books = Book.page(params[:page]).reverse_order
  	@book = Book.new
    @user = current_user
  end

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.page(params[:page]).reverse_order
    @user = @book.user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to books_path
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    @user = @book.user
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path
    else
      render :edit
    end
  end

  def destroy
  	@book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def about
  end

  def correct_user                                                              # 正しいユーザーかどうか確認
      @book = Book.find(params[:id])                                            # URLのidの値と同じユーザーを@userに代入
      redirect_to books_path unless @book.user == current_user
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
