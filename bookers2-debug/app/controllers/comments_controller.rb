class CommentsController < ApplicationController
    def create
        book = Book.find(params[:book_id])
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.book_id = book.id
        @comment.save
        redirect_to book
    end

    def destroy
        book = Book.find(params[:id])
        @comment = book.comments.find(params[:book_id])
        @comment.destroy
        redirect_to book
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end