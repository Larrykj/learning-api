class Api::BooksController < ApplicationController
  # Protect write operations (only enforced when API_KEY env var is set)
  before_action :require_api_key!, only: %i[create update destroy]
  before_action :set_book, only: %i[show update destroy]
  before_action :require_admin!, only: %i[create update destroy]

  # GET /api/v1/books
  # Supports: ?page=1&per_page=10&sort=title&order=asc
  def index
    per_page = (params[:per_page] || 10).to_i.clamp(1, 100)
    page     = (params[:page] || 1).to_i.clamp(1, Float::INFINITY)
    offset   = (page - 1) * per_page

    sort_col   = %w[title author created_at].include?(params[:sort]) ? params[:sort] : "created_at"
    sort_order = params[:order] == "asc" ? :asc : :desc

    books       = Book.order(sort_col => sort_order)
    total_count = books.count
    paginated   = books.limit(per_page).offset(offset)

    render json: {
      data: paginated,
      meta: {
        current_page: page,
        per_page: per_page,
        total_count: total_count,
        total_pages: (total_count.to_f / per_page).ceil
      }
    }
  end

  # GET /api/v1/books/:id
  def show
    render json: { data: @book }
  end

  # POST /api/v1/books
  def create
    book = Book.new(book_params)
    if book.save
      render json: { data: book }, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/books/:id
  def update
    if @book.update(book_params)
      render json: { data: @book }
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/books/:id
  def destroy
    @book.destroy
    head :no_content
  end

  # GET /api/v1/books/search?q=ruby
  def search
    query = params[:q]
    if query.blank?
      render json: { error: "Search query is required" }, status: :bad_request
      return
    end

    books = Book.where("title ILIKE ? OR author ILIKE ?", "%#{query}%", "%#{query}%")

    render json: {
      data: books,
      meta: {
        query: query,
        results_count: books.count
      }
    }
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
module Api
    class BooksController < ApplicationController
        def title
            title = params[:title].to_s

            render json: {
                title: title
            }
        end
    end
end
