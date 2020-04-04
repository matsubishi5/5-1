class BooksController < ApplicationController
	before_action :set_book, only: [:show, :edit, :update, :destroy]

  def show
      @comment = Comment.new
      @comments = @book.comments.order(created_at: :desc)
  end

  def index
	@book = Book.new
  	@books = Book.all.order(created_at: :desc) #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
	@book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
	  unless @book.user == current_user
		redirect_to books_path
	  end
  end

  def update
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
	end

	def set_book
		@book = Book.find(params[:id])
	end
	
end
