module Controllers
  class ApplicationController < ActionController::API
    rescue_from ActiveModel::ValidationError, with: :invalid_params

    protected

      def invalid_params(exception)
        render json: { error: exception.message }.to_json, status: 422
      end
  end
end
