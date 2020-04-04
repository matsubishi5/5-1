class FavoritesController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        unless current_user.favorited_by?(@book)
            favorite = current_user.favorites.new(book_id: @book.id)
            favorite.save
        end
    end
    
    def destroy
        @book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: @book.id)
        favorite.destroy
    end
end
