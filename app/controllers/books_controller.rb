class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    #アプリ2 10章：ログイン中のユーザ情報を取得できる
    @user = current_user

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    #userとbookを指定しないとエラーになる
    else
      @user = current_user
      @books = Book.all
      render :index
    end

  end

  def show
    @book = Book.find(params[:id])
    #投稿フォームには新しい何も指定していないbookを持ってこなければならないが、ここでは既に@bookを使用しているので他で代用する。
    ##部分テンプレートで、ローカル変数(book)に変えて、インスタンス変数(@book_new)を代入して実装する。
    @book_new = Book.new
    #indexで作った@userアクションをコピペNG show画面でもcurrent_userだと、他の人の詳細画面でも自分のUserinfoになってしまう。
    @user = @book.user
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
       flash[:notice] = "Book was successfully updated."
       redirect_to book_path(book.id)
    else
      @book = Book.find(params[:id])
      @book.update(book_params)
       render :edit
    end
  end

   def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
   end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
