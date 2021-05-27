class BooksController < ApplicationController
  before_action :authenticate_author!, only: [:create]

  def show
    @book = Book.find_by_id(params[:id])
  end

  def create
    @book = Book.create(
      author: current_author,
      isbn: book_params[:isbn],
      title: book_params[:title],
      publisher: book_params[:publisher],
      publication_year: book_params[:publication_year],
      publication_country_code: book_params[:publication_country_code])
    cover_image = MiniMagick::Image.new(book_params[:cover_image].tempfile.path)
    cover_image.resize "200x200>"
    @book.cover_image.attach(book_params[:cover_image])
  end

  private

  def book_params
    params.permit(:isbn, :title, :publisher, :publication_year, :publication_country_code, :cover_image)
  end
end
