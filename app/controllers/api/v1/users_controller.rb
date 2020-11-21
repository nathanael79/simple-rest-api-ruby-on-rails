module Api
  module V1
    class UsersController < ApplicationController
      def index
        user = User.all

        if user.empty?
          render json: {
            message: "There are no active data"
          }, status: :no_content
        else
          render json: {
            message: "success",
            data: user
          }, status: :ok
        end

      end

      def create
        newUser = User.new(user_params)

        if newUser.save
          render json: {
              message: "success",
              data: newUser
          }, status: :created
        else
          render json: {
              error: "Error, cant create!"
          }, status: :bad_request
        end
      end

      def show
        user = User.find(params[:id])

        if user.present?
          success_response(user)
        else
          not_found_response
        end

      end


      def update
        activeUser = User.find(params[:id])

        if activeUser.present?
          activeUser.update(user_params)

          if activeUser.save
            success_response(activeUser)
          else
            error_response
          end

        else
          not_found_response
        end

      end

      def destroy
        activeUser = User.find(params[:id])

        if activeUser.present?
          activeUser.destroy
          success_response(nil)
        else
          not_found_response
        end
      end


      private

      def user_params
        params.permit(:name, :email, :password)
      end

      def blank_data_response
        render json: {
            error: "There are no active data"
        }, status: :no_content
      end

      def success_response(*data)
        render json:{
            message: "Success",
            data: data
        }, status: :ok
      end

      def not_found_response
        render json:{
            error: "Not found"
        }, status: :not_found
      end

      def error_response
        render json: {
            error: "Error!"
        }, status: :internal_server_error
      end

    end
  end
end
