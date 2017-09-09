# frozen_string_literal: true

module Api
  module V1
    module Connect
      class CategoriesController < ApplicationController
        def index
          render json: categories
        end

        private

        def categories
          @categories ||= Rails.application.config_for(:connect_categories)
        end
      end
    end
  end
end
