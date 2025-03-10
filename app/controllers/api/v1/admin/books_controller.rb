module Api
  module V1
    module Admin
      class BooksController < ApplicationController
        # before_action :authenticate_admin_user!

        def index
          books = BookMongo.page(params[:page] || 1).per(Settings.app.items_per_page)
          render json: BookSerializer.new(books)
        end
      end
    end
  end
end
