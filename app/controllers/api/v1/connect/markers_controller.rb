module Api
  module V1
    module Connect
      class MarkersController < ApplicationController
        def index
          @filters = {}
          @markers = ::Connect::Marker.unresolved.all

          if params[:lat].present? && params[:lon].present?
            @filters[:lat] = params[:lat]
            @filters[:lon] = params[:lon]
            @filters[:rad] = params.fetch(:rad, 10).to_i
            @markers = @markers.near([@filters[:lat], @filters[:lon]], @filters[:rad])
          end

          if params[:category].present?
            @filters[:category] = params[:category]
            @markers = @markers.where("category ILIKE ?", "%#{params[:category]}%")
          end

          if params[:type].present?
            @filters[:type] = params[:type]
            @markers = @markers.where(marker_type: params[:type])
          end

          if params[:limit].to_i > 0
            @filters[:limit] = params[:limit].to_i
            @markers = @markers.limit(params[:limit].to_i)
          end
        end

        def create
          @marker = ::Connect::Marker.new(marker_params)
          if @marker.save
            render :show, status: :created, location: @marker
          else
            render json: @marker.errors, status: :unprocessable_entity
          end
        end

        def update
          @marker = ::Connect::Marker.find(params[:id])
          if @marker.update(marker_params)
            render :show, status: :ok, location: @marker
          else
            render json: @marker.errors, status: :unprocessable_entity
          end
        end

        private

        def marker_params
          params.require(:marker)
                .permit(:category,
                        :description,
                        :email,
                        :latitude,
                        :longitude,
                        :marker_type,
                        :name,
                        :phone,
                        :resolved)
                .tap do |marker|
                  marker[:device_uuid] = params.dig(:marker, :device_uuid) if action_name == "create"
                  marker[:data] = params.dig(:marker, :data).permit! if params.dig(:marker, :data)
                end
        end
      end
    end
  end
end
