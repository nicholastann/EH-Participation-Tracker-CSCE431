# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        students = Student.all

        render json: StudentSerializer.new(students).serialized_json
      end

      def show
        student = Student.find_by(uin: params[:uin])

        render json: StudentSerializer.new(student).serialized_json
      end

      def create
        student = Student.new(student_params)

        if student.save
          render json: StudentSerializer.new(student).serialized_json
        else
          render json: { error: student.errors.messages }, status: 422
        end
      end

      def update
        student = Student.find_by(uin: params[:uin])

        if student.update(student_params)
          render json: StudentSerializer.new(student).serialized_json
        else
          render json: { error: student.errors.messages }, status: 422
        end
      end

      def destroy
        if student.destroy
          head :no_content
        else
          render json: { error: student.errors.messages }, status: 422
        end
      end

      private

      def student_params
        params.require(:student).permit(:uin, :firstName, :lastName, :email, :year, :gpa, :major, :status)
      end
    end
  end
end
