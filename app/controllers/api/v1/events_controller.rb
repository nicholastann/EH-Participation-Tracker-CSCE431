# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        events = Event.all

        render json: EventSerializer.new(event).serialized_json
      end

      def show
        event = Event.find(params[:id])

        render json: EventSerializer.new(event).serialized_json
      end

      def create
        event = Event.new(event_params)

        if event.save
          render json: EventSerializer.new(event).serialized_json
        else
          render json: { error: event.errors.messages }, status: 422
        end
      end

      def update
        event = Event.find(params[:id])

        if event.update(event_params)
          render json: EventSerializer.new(event).serialized_json
        else
          render json: { error: event.errors.messages }, status: 422
        end
      end

      def destroy
        if event.destroy
          head :no_content
        else
          render json: { error: event.errors.messages }, status: 422
        end
      end

      private

      def event_params
        params.require(:event).permit(:name, :date, :description, :event_type, :location)
      end
    end
  end
end
