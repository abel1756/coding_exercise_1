class AuthorsController < ApplicationController
  before_action :authenticate_author!, only: [:show, :books]

  def show
    respond_to do |format|
      format.html do
        @current_author = current_author
      end
      format.json do
        render json: current_author
      end
    end
  end

  def books
    respond_to do |format|
      format.json do
        render json: current_author.books
      end
    end
  end
end
